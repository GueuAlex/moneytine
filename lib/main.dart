import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

import 'functions/local_notification_services.dart';
import 'splash.dart';
import 'style/palette.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  //print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //print('Got a message whilst in the foreground!');
    //print('Message data: ${message.data}');

    if (message.notification != null) {
      LocalNotificationService().display(message);
      //print('Message also contained a notification: ${message.notification}');
    }
  });

  //FirebaseAnalytics.logEvent(name: 'notification_received');

  //initializeDateFormatting().then((_) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      locale: const Locale('eu', 'FR'),
      title: 'MoneyTine',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Alberta",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            color: Palette.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Palette.primarySwatch,
        ).copyWith(
          secondary: Palette.appPrimaryColor,
        ),
      ),
      darkTheme: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(), // This is required
        ),
      ),
      //home: const MyHomePage(title: 'MoneyTine'),
      home: const SplashCreen(),
      //home: CountdownWidget(endDate: DateTime.now().add(Duration(days: 30))),
      //home: const PinCodeScreen(),
      //home: SuperposedCarousel(),
      //home: const HomePageScreen(),
      //home: const DropDownListExample(),
    );
  }
}
