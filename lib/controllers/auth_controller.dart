import 'dart:io';
import 'dart:math';
import 'dart:convert';
import '../services/push_notifications.dart';
import '../auth/chose_height_screen.dart';
import '../auth/select_allergies_screen.dart';
import '../auth/select_goals_screen.dart';
import '../auth/start_screen.dart';
import '../models/user_model/user_plan_model.dart';
import '../utils/constants.dart';
import '../auth/select_gender.dart';
import '../functions/global_functions.dart';
import '../services/firebase_analytics.dart';
import '../utils/strings.dart';
import '../widgets/dialogs.dart';
import '../auth/signin_screen.dart';
import '../auth/onboarding_screen.dart';
import '../screens/main_screens/main_screen.dart';
import '../auth/chose_weight_screen.dart';
import '../models/user_model/user_model.dart';
import '../models/user_model/medical_report_model.dart';
import '../shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static UserModel currentUser;

  /*******************************************************
                    FUNCTION TO SIGN UP
   **************************************************////

  Future<bool> signupWithCredentials(BuildContext context, File file, String password) async {
    try {
      UserCredential userCredential = await this._auth.createUserWithEmailAndPassword(email: currentUser.email, password: password);
      _auth.currentUser.sendEmailVerification();
      currentUser.uid = userCredential.user.uid;
      currentUser.parq = [];
      currentUser.reports = null;
      currentUser.bfp = 0.0;
      currentUser.neck = null;
      currentUser.hips = null;
      currentUser.waist = null;
      currentUser.fcm = await PushNotificationService().getDeviceId();
      currentUser.mealPlanDetail = null;
      currentUser.workoutPlanDetail = null;
      currentUser.supplementPlanDetail = null;
      currentUser.updatePlan = false;
      currentUser.mentalHealth = false;
      currentUser.bmi = 0.0;
      currentUser.macroNutrients = {};
      currentUser.instructors = ['ihzsHTUyCgUVUpy6lN8bMXjuap02'];
      currentUser.hire = {'chef': false, 'trainer': false,};
      currentUser.createdAt = Timestamp.now();
      currentUser.accountStatus = 0;
      if (file != null) currentUser.profileImageUrl = await _uploadProfileImage(file);
      await _firestore.doc(FirebaseRef.USERS + "/" + currentUser.uid).set(currentUser.toMap());
      FirebaseAnalyticsService.logEvent('Sign up');
      return true;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case FirebaseRef.EMAIL_ALREADY_EXISTS:
          AppDialog()
              .showOSDialog(context, StringRefer.Error, StringRefer.kAlreadyExist, StringRefer.Ok, () {});
          break;
        case FirebaseRef.NO_CONNECTION:
          AppDialog()
              .showOSDialog(context, StringRefer.Error, StringRefer.kNoConnection, StringRefer.Ok, () {});
          break;
      }
      return false;
    }
  }

  /*******************************************************
            FUNCTION TO LOGIN WITH CREDENTIALS
   **************************************************////

  Future<void> loginWithCredentials(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await this._auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseAnalyticsService.logEvent('Login with credentials');
      if (!userCredential.user.emailVerified) {
        AppDialog().showOSDialog(context, 'Warning', StringRefer.emailNotVerify, StringRefer.Ok, () {});
      } else {
        await checkUserExists(context, uid: userCredential.user.uid, loginWithCredential: true);
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case FirebaseRef.WRONG_PASSWORD:
          AppDialog()
              .showOSDialog(context, StringRefer.Error, StringRefer.kInvalidPassword, StringRefer.Ok, () {});
          break;
        case FirebaseRef.USER_NOT_EXISTS:
          AppDialog()
              .showOSDialog(context, StringRefer.Error, StringRefer.kNoUserFound, StringRefer.Ok, () {});
          break;
        case FirebaseRef.NO_CONNECTION:
          AppDialog()
              .showOSDialog(context, StringRefer.Error, StringRefer.kNoConnection, StringRefer.Ok, () {});
          break;
      }
      return;
    }
  }

  /*******************************************************
              FUNCTION TO LOGIN WITH GOOGLE
   **************************************************////

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await this._auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        FirebaseAnalyticsService.logEvent('Login with google');
        await checkUserExists(context, uid: user.uid);
      }
    } catch (e) {}
  }

  /*******************************************************
            FUNCTION TO LOGIN WITH FACEBOOK
   **************************************************////

  Future<void> loginWithFacebookLogin(BuildContext context) async {
    try {
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken.token);
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        final User user = authResult.user;
        if (user != null) {
          FirebaseAnalyticsService.logEvent('Login with Facebook');
          await checkUserExists(context, uid: user.uid);
        }
      } else {
        print(loginResult.message);
      }
    } catch (e) {
      print(e);
    }
  }

  /*******************************************************
             FUNCTION TO LOGIN WITH APPLE
   **************************************************////

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final AppleSignInAvailable appleSignInAvailable = await AppleSignInAvailable.check();
      if (!appleSignInAvailable.isAvailable) {
        AppDialog().showOSDialog(context, "Error", "Apple Sign in not available", "Ok", () {});
        return;
      }
      final String _appleProvider = "apple.com";
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider(_appleProvider).credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final authResult = await this._auth.signInWithCredential(oauthCredential);
      final firebaseUser = authResult.user;
      if (firebaseUser != null) {
        FirebaseAnalyticsService.logEvent('login_with_apple');
        await checkUserExists(context, uid: firebaseUser.uid);
      }
    } on SignInWithAppleException catch (e) {
      print("Apple Login Error: $e");
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: $e");
    }
  }
  String _generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /*******************************************************
            FUNCTION TO UPLOAD PROFILE IMAGE
   **************************************************////

  Future<String> _uploadProfileImage(File file) async {
    try {
      await _firebaseStorage.ref(FirebaseRef.PROFILE_IMAGE + "/" + currentUser.uid).putFile(file);
      final downloadURL =
          await _firebaseStorage.ref(FirebaseRef.PROFILE_IMAGE + "/" + currentUser.uid).getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print("File upload Error: $e");

      return null;
    }
  }

  /*******************************************************
          FUNCTION TO UPLOAD USER REPORT FILE
   **************************************************////

  Future<String> _uploadUserReport(File file, String name) async {
    try {
      await _firebaseStorage.ref(FirebaseRef.USER_REPORT + "/" + currentUser.uid + "/" + name).putFile(file);
      final downloadURL = await _firebaseStorage
          .ref(FirebaseRef.USER_REPORT + "/" + currentUser.uid + "/" + name)
          .getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print("File upload Error: $e");
      return null;
    }
  }

  /*********************************************************
        FUNCTION TO CHECK USER EXIST AND ASSIGN VALUES
   *******************************************************////

  Future<void> checkUserExists(BuildContext context, {String uid, bool loginWithCredential = false}) async {
    User currentAuthUser = this._auth.currentUser;
    if (currentAuthUser == null || currentAuthUser.emailVerified == false) {
      bool areOnBoardingScreensVisited =
          LocalPreferences.preferences.getBool(LocalPreferences.OnBoardingScreensVisited);
      getAppData();
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, OnBoardingScreen.firstScreenId);
        Navigator.pushReplacementNamed(
            context,
            areOnBoardingScreensVisited != null && areOnBoardingScreensVisited
                ? SignInScreen.signInScreenID
                : OnBoardingScreen.firstScreenId);
      });
      return;
    }
    DocumentSnapshot snapshot = await _firestore.doc("${FirebaseRef.USERS}/${uid ?? currentAuthUser.uid}").get();
    if (!snapshot.exists) {
      if (!loginWithCredential) {
        currentUser = UserModel(
            name: currentAuthUser.displayName ?? "User", email: currentAuthUser.email,
            accountStatus: 0, bfp: 0.0, bmi: 0.0, neck: null, hips: null, waist: null,
            parq: [], reports: null, updatePlan: false, mentalHealth: false, mealPlanDetail: null,
            workoutPlanDetail: null, supplementPlanDetail: null, macroNutrients: {},
            fcm: await PushNotificationService().getDeviceId(),
            hire: {'chef': false, 'trainer': false,}, instructors: ['ihzsHTUyCgUVUpy6lN8bMXjuap02'],
            profileImageUrl: currentAuthUser.photoURL, createdAt: Timestamp.now(), uid: currentAuthUser.uid
        );
        await _firestore.doc(FirebaseRef.USERS + '/' + currentUser.uid).set(currentUser.toMap());
        clearData(); await getAppData(); await getUserData();
        Navigator.pushReplacementNamed(context, StartScreen.ID);
      }
      return;
    }
    currentUser = UserModel.fromMap(snapshot.data());
    clearData();
    await getAppData();
    await getUserData();
    if (currentUser.age == null) {
      Navigator.pushReplacementNamed(context, StartScreen.ID);
      return;
    }
    if (currentUser.gender == null) {
      Navigator.pushReplacementNamed(context, SelectGender.ID);
      return;
    }
    if (currentUser.weight == null) {
      Navigator.pushReplacementNamed(context, SelectWeightScreen.ID);
      return;
    }
    if (currentUser.height == null) {
      Navigator.pushReplacementNamed(context, SelectHeightScreen.ID);
      return;
    }
    if (currentUser.allergies == null) {
      Navigator.pushReplacementNamed(context, SelectAllergies.ID);
      return;
    }
    if (currentUser.selectedGoal == null) {
      Navigator.pushReplacementNamed(context, SelectGoalsScreen.ID);
      return;
    }
    if (currentUser.accountStatus == 1) {
      Navigator.pushReplacementNamed(context, MainScreen.MainScreenId);
    }
    if (currentUser.accountStatus == 0) {
      _auth.signOut();
      AppDialog()
          .showOSDialog(context, StringRefer.Approval, StringRefer.accountNotApprove, StringRefer.Ok, () {});
    }
  }

  /***************************************
      FUNCTION TO UPDATE USER IMAGE
   **********************************////

  Future<void> updateUserImages(File file) async {
    try {
      if (file != null) {
        currentUser.profileImageUrl = await _uploadProfileImage(file);
        await _firestore.doc(FirebaseRef.USERS + '/' + currentUser.uid).update(currentUser.toMap());
        FirebaseAnalyticsService.logEvent('Profile image updated');
      }
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  /**************************************************
        FUNCTION TO UPDATE USER REPORT FILES
   *********************************************////

  Future<void> updateUserReportFiles(File file, String name, int fileNo, bool update) async {
    try {
      if (file != null) {
        String fileName = await _uploadUserReport(file, name);
        MedicalReportModel report = MedicalReportModel();
        report.name = name;
        report.file = fileName;
        report.type = fileNo;
        currentUser.reports.removeWhere((element) => element['type'] == fileNo);
        currentUser.reports.add(report.toMap());
      }
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  /**************************************************
          FUNCTION TO UPDATE USER DATA
   *********************************************////

  Future<void> updateUserFields() async {
    try {
      await _firestore.doc(FirebaseRef.USERS + '/' + currentUser.uid).update(currentUser.toMap());
      FirebaseAnalyticsService.logEvent('User data updated');
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  Future<void> updatePlan(bool update) async {
    try {
      await _firestore.collection('users').doc(currentUser.uid).update({'update_plan': update});
      FirebaseAnalyticsService.logEvent('User data updated');
    } on FirebaseException catch (e) {
      print("User update Error: $e");
    }
  }

  /*************************************************************
          FUNCTION TO GET USER PLAN INFO
   ********************************************************////

  static Future<void> getUserInfo(String uid) async {
    try {
      DocumentSnapshot snapShot = await _firestore.collection('users').doc(uid).get();
      if (snapShot.exists) {
        currentUser = UserModel.fromMap(snapShot.data());
        if (currentUser.parq == null) currentUser.parq = [];
        if (currentUser.reports == null) currentUser.reports = [];
        if (currentUser.macroNutrients == null) currentUser.macroNutrients = {};
        if (currentUser.mealPlanDetail != null) {
          Constants.planMealAssign = true;
          Constants.mealPlanDetail = PlanModel.fromMap(currentUser.mealPlanDetail);
        }
        if (currentUser.workoutPlanDetail != null) {
          Constants.planWorkoutAssign = true;
          Constants.workoutPlanDetail = PlanModel.fromMap(currentUser.workoutPlanDetail);
        }
        if (currentUser.supplementPlanDetail != null) {
          Constants.planSupplementAssign = true;
          Constants.supplementPlanDetail = PlanModel.fromMap(currentUser.supplementPlanDetail);
        }
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
            FUNCTION TO RESET PASSWORD
   *********************************************////

  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      await this._auth.sendPasswordResetEmail(email: email);
      FirebaseAnalyticsService.logEvent('Password reset email sent');
      AppDialog().showOSDialog(context, "Success", "Password reset email sent successfully", "Ok", () {
        Navigator.pushNamedAndRemoveUntil(context, SignInScreen.signInScreenID, (route) => false);
      });
    } on FirebaseException catch (e) {
      print("Password Reset Error: $e");
    }
  }
}

class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await SignInWithApple.isAvailable());
  }
}

class FirebaseRef {
  static const String USERS = "users";
  static const String PROFILE_IMAGE = "profile_image";
  static const String USER_REPORT = "user_report";
  static const String WRONG_PASSWORD = "wrong-password";
  static const String USER_NOT_EXISTS = "user-not-found";
  static const String EMAIL_ALREADY_EXISTS = "email-already-in-use";
  static const String NO_CONNECTION = "network-request-failed";
}
