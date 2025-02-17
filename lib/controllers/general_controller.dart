import 'dart:io';
import 'auth_controller.dart';
import '../functions/global_functions.dart';
import '../models/user_model/qoutes_model.dart';
import '../models/user_model/user_weight_model.dart';
import '../models/user_plan_data_model/notification_model.dart';
import '../models/user_model/par_q_model.dart';
import '../utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class GeneralController{
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /**************************************************
      FUNCTION TO GET PARQ-QUESTIONS
   *********************************************////

  static Future<void> getPARQ() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('par_questions').get();
      snapShot.docs.forEach((element) {
          PARQModel parqData = PARQModel.fromMap(element.data());
          Constants.parQList.add(parqData);
      });
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
      FUNCTION TO GET QOUTES
   *********************************************////

  static Future<void> getQoutes() async {
    try {
      DocumentSnapshot snapShot = await _firestore.collection('qoutes').doc('qoutes_array').get();
      if (snapShot.exists) {
        Constants.qoutes = Qoutes.fromMap(snapShot.data());
      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
      FUNCTION TO SAVE SETUP-NOTIFICATION DATA
   *********************************************////

  static Future<void> notificationData({String title, String body, int type, int meal}) async {
    NotificationModel notificationDetail = NotificationModel();
    notificationDetail.title = title;
    notificationDetail.body = body;
    notificationDetail.type = type;
    notificationDetail.md = Constants.todayMealDetail.mealsInEachDay;
    notificationDetail.mealPortion = meal;
    notificationDetail.createdAt = Timestamp.now();
    notificationDetail.userId = AuthController.currentUser.uid;
    var ref = await _firestore.collection('notifications').add(notificationDetail.toMap());
    notificationDetail.id = ref.id;
    await _firestore.collection('notifications').doc(ref.id).set(notificationDetail.toMap());
    return;
  }

  /**************************************************
      FUNCTION TO UPLOAD CHAT (IMAGE/VIDEO) FILE
   *********************************************////

  static Future<String> uploadChatFile(File file, thread) async {
    try {
      await FirebaseStorage.instance.ref('chat_files' + "/" + thread + "/" + file.name).putFile(file);
      final downloadURL =
      await FirebaseStorage.instance.ref('chat_files' + "/" + thread + "/" + file.name).getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print("File upload Error: $e");
      return null;
    }
  }

  /**************************************************
          FUNCTION TO GET USER WEIGHT DATA
   *********************************************////

  static Future<void> getUserWeight() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('user_weight_data').where('uid', isEqualTo: AuthController.currentUser.uid).get();
      if(snapShot.docs.isNotEmpty){
        if(Constants.planDetail.weight == 1) await dbHelper.removeWeight();
        final meals = snapShot.docs;
        Future.wait(
            meals.map((e) async{
              UserWeightModel data = UserWeightModel.fromMap(e.data());
              await dbHelper.insertWeightData(data);
            })
        );
      }
      await dbHelper.setWeightPlan();
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
       FUNCTION TO GET CURRENT WEIGHT OF USER
   *********************************************////

  static Future<void> getDailyWeight() async {
    try {
      QuerySnapshot snapShot = await _firestore.collection('user_weight_data')
          .where('uid', isEqualTo: AuthController.currentUser.uid).orderBy('date', descending: true).get();
      if (snapShot.docs.isNotEmpty) {
        Constants.dailyWeight = UserWeightModel.fromMap(snapShot.docs.first.data());

      }
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

  /**************************************************
         FUNCTION TO SAVE USER WEIGHT
   *********************************************////

  static Future<void> saveUserWeight(UserWeightModel weightData) async {
    try {
      await _firestore.collection('user_weight_data').doc(weightData.id).set(weightData.toMap());
      return;
    } on SocketException catch (error) {
      print("$error");
    } on FirebaseException catch (error) {
      print("$error");
    }
  }

}