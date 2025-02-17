import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:t_fit/auth/chose_height_screen.dart';
import 'package:t_fit/auth/hire_expert_screen.dart';
import 'package:t_fit/auth/par_q_start.dart';
import 'package:t_fit/auth/privacy_policy_screen.dart';
import 'package:t_fit/auth/select_allergies_screen.dart';
import 'package:t_fit/auth/select_goals_screen.dart';
import 'package:t_fit/auth/term_condition_screen.dart';
import 'package:t_fit/auth/user_name_screen.dart';
import 'package:t_fit/localization/locale_constant.dart';
import 'package:t_fit/localization/localizations_delegate.dart';
import 'package:t_fit/screens/calculators/bmi_calculator_screen.dart';
import 'package:t_fit/screens/calculators/calculator_main_screen.dart';
import 'package:t_fit/screens/chat_screens/chat_main_screen.dart';
import 'package:t_fit/screens/chat_screens/chat_screen.dart';
import 'package:t_fit/screens/calculators/fat_calculator_result_screen.dart';
import 'package:t_fit/screens/calculators/fat_calculator_screen.dart';
import 'package:t_fit/screens/calculators/macro_calculator_result_screen.dart';
import 'package:t_fit/screens/calculators/macro_calculator_screen.dart';
import 'package:t_fit/screens/history_screens/history_main_screen.dart';
import 'package:t_fit/screens/history_screens/plans_list_screen.dart';
import 'package:t_fit/screens/history_screens/user_detail_screen.dart';
import 'package:t_fit/screens/main_screens/main_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/meal_plan/meal_plan_detail_screen.dart';
import 'package:t_fit/screens/mental_health_screens/journal_list_screen.dart';
import 'package:t_fit/screens/mental_health_screens/mReading_list_screen.dart';
import 'package:t_fit/screens/mental_health_screens/mindfulness_breathing.dart';
import 'package:t_fit/screens/mental_health_screens/mindfulness_reading.dart';
import 'package:t_fit/screens/mental_health_screens/play_sound_screen.dart';
import 'package:t_fit/screens/mental_health_screens/read_article_sceen.dart';
import 'package:t_fit/screens/mental_health_screens/sounds_list_screen.dart';
import 'package:t_fit/screens/mental_health_screens/write_journal_screen.dart';
import 'package:t_fit/screens/mental_health_screens/written_blog_screen.dart';
import 'package:t_fit/screens/notification_screens/add_alert_screen.dart';
import 'package:t_fit/screens/notification_screens/blog_favorites_blog.dart';
import 'package:t_fit/screens/notification_screens/notification_screen.dart';
import 'package:t_fit/screens/notification_screens/notification_setting_screen.dart';
import 'package:t_fit/screens/par_q_screens/par_attachment.dart';
import 'package:t_fit/screens/par_q_screens/par_q_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/meal_plan/meal_week_plan_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/meal_plan/meal_month_plan_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/supplements_plan/suppliment_month_plan_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/supplements_plan/suppliment_plan_detail_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/supplements_plan/suppliment_week_plan_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/workout_plan/workout_month_plan_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/workout_plan/workout_plan_detail_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/workout_plan/workout_video_screen.dart';
import 'package:t_fit/screens/diet_plan_screens/workout_plan/workout_week_plan_screen.dart';
import 'package:t_fit/screens/weight_screens/measure_weight_screen.dart';
import 'package:t_fit/screens/weight_screens/monthly_history_screen.dart';
import 'package:t_fit/screens/weight_screens/weekly_history_screen.dart';
import 'package:t_fit/screens/weight_screens/weight_history_screen.dart';
import 'package:t_fit/services/notification_initialization.dart';
import 'package:t_fit/services/push_notifications.dart';
import 'package:t_fit/services/theme_model.dart';
import 'package:t_fit/utils/colors.dart';
import 'package:t_fit/utils/fonts.dart';
import 'auth/chose_weight_screen.dart';
import 'auth/select_age_screen.dart';
import 'auth/select_gender.dart';
import 'auth/signin_screen.dart';
import 'auth/signup_screen.dart';
import 'auth/start_screen.dart';
import 'auth/forget_password_screen.dart';
import 'auth/splash_screen.dart';
import 'auth/onboarding_screen.dart';
import 'auth/second_intro_screen.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'cards/blog_pdf.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'screens/chat_screens/file_send_in_chat.dart';
import 'screens/mental_health_screens/mind_fullness_screen.dart';

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _configureLocalTimeZone();
  NotificationInitialization.initNotifications(flutterLocalNotificationsPlugin);
  PushNotificationService.listenNotifications();
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.lightTheme = await themeChangeProvider.lightThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(builder: (BuildContext context, value, Widget child){
        return MaterialApp(
          navigatorKey: navigatorKey,
          themeMode: ThemeMode.dark,
          darkTheme: value.lightTheme ?
          ThemeData(brightness: Brightness.light, appBarTheme: AppBarTheme(color: Colors.white, titleTextStyle: TextStyle(color: ColorRefer.kDarkGreyColor, fontFamily: FontRefer.OpenSans, fontSize: 18), iconTheme: IconThemeData(color: ColorRefer.kDarkGreyColor))) :
          ThemeData(brightness: Brightness.dark),
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: [
            Locale('en', ''),
            Locale('ar', ''),
            Locale('ch', ''),
            Locale('ru', ''),
            Locale('es', ''),
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale?.languageCode == locale?.languageCode &&
                  supportedLocale?.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales?.first;
          },
          initialRoute: SplashScreen.splashScreenId,
          routes: {
            SplashScreen.splashScreenId: (context) => SplashScreen(),
            SignUpScreen.signUpScreenID: (context) => SignUpScreen(),
            SignInScreen.signInScreenID: (context) => SignInScreen(),
            StartScreen.ID: (context) => StartScreen(),
            ForgetPasswordScreen.ID: (_) => ForgetPasswordScreen(),
            SelectGender.ID: (context) => SelectGender(),
            SelectAge.ID: (context) => SelectAge(),
            PDFCard.ID: (context) => PDFCard(),
            SelectWeightScreen.ID: (context) => SelectWeightScreen(),
            SelectHeightScreen.ID: (context) => SelectHeightScreen(),
            SelectAllergies.ID: (context) => SelectAllergies(),
            OnBoardingScreen.firstScreenId: (context) => OnBoardingScreen(),
            SecondIntroScreen.secondScreenId: (context) => SecondIntroScreen(),
            SelectGoalsScreen.ID: (context) => SelectGoalsScreen(),
            MainScreen.MainScreenId: (context) => MainScreen(),
            MealWeekPlanScreen.ID: (context) => MealWeekPlanScreen(),
            NotificationScreen.ID: (context) => NotificationScreen(),
            UserNameScreen.ID: (context) => UserNameScreen(),
            PARQScreen.ID: (context) => PARQScreen(),
            BlogFavoritesScreen.ID: (context) => BlogFavoritesScreen(),
            MealMonthPlanScreen.ID: (context) => MealMonthPlanScreen(),
            MealPlanDetailScreen.ID: (context) => MealPlanDetailScreen(),
            WorkoutMonthPlanScreen.ID: (context) => WorkoutMonthPlanScreen(),
            WorkoutWeekPlanScreen.ID: (context) => WorkoutWeekPlanScreen(),
            WorkoutPlanDetailScreen.ID: (context) => WorkoutPlanDetailScreen(),
            WorkoutVideoScreen.ID: (context) => WorkoutVideoScreen(),
            PARQStartScreen.ID: (context) => PARQStartScreen(),
            CalculatorMainScreen.ID: (context) => CalculatorMainScreen(),
            BMICalculatorScreen.ID: (context) => BMICalculatorScreen(),
            MacroCalculatorScreen.ID: (context) => MacroCalculatorScreen(),
            MacroCalculatorResultScreen.ID: (context) => MacroCalculatorResultScreen(),
            FatCalculatorScreen.ID: (context) => FatCalculatorScreen(),
            FatCalculatorResultScreen.ID: (context) => FatCalculatorResultScreen(),
            SupplimentMonthPlanScreen.ID: (context) => SupplimentMonthPlanScreen(),
            SupplementWeekPlanScreen.ID: (context) => SupplementWeekPlanScreen(),
            SupplementPlanDetailScreen.ID: (context) => SupplementPlanDetailScreen(),
            ChatMainScreen.ID: (context) => ChatMainScreen(),
            ChatScreen.ID: (context) => ChatScreen(),
            PARQAttachmentScreen.ID: (context) => PARQAttachmentScreen(),
            FileSendInChatScreen.ID: (context) => FileSendInChatScreen(),
            HireExpertScreen.ID: (context) => HireExpertScreen(),
            PlanHistoryScreen.ID: (context) => PlanHistoryScreen(),
            PlanListScreen.ID: (context) => PlanListScreen(),
            UserPlanDetailScreen.ID: (context) => UserPlanDetailScreen(),
            SetUpNotificationScreen.ID: (context) => SetUpNotificationScreen(),
            MindFullnessMainScreen.ID: (context) => MindFullnessMainScreen(),
            WrittenBlogScreen.ID: (context) => WrittenBlogScreen(),
            SoundBlogScreen.ID: (context) => SoundBlogScreen(),
            ReadArticle.ID: (context) => ReadArticle(),
            PlaySoundScreen.ID: (context) => PlaySoundScreen(),
            WeightHistoryScreen.ID: (context) => WeightHistoryScreen(),
            WriteDiaryScreen.ID: (context) => WriteDiaryScreen(),
            JournalScreen.ID: (context) => JournalScreen(),
            BreathExerciseScreen.ID: (context) => BreathExerciseScreen(),
            MeasureWeightScreen.ID: (context) => MeasureWeightScreen(),
            MindFullnessReadingScreen.ID: (context) => MindFullnessReadingScreen(),
            ReadingListScreen.ID: (context) => ReadingListScreen(),
            PrivacyPolicyScreen.ID: (context) => PrivacyPolicyScreen(),
            TermConditionScreen.ID: (context) => TermConditionScreen(),
            WeeklyWeightHistoryScreen.ID: (context) => WeeklyWeightHistoryScreen(),
            MonthlyWeightHistoryScreen.ID: (context) => MonthlyWeightHistoryScreen(),
            NotificationSettingScreen.ID: (context) => NotificationSettingScreen(),
          },
        );
      }
    ));
  }
}
