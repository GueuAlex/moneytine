import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytine/splash.dart';
import 'package:moneytine/style/palette.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // This is required
      ],
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
                fontWeight: FontWeight.w600)),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Palette.appPrimaryColor),
      ),
      darkTheme: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(), // This is required
        ),
      ),
      //home: const MyHomePage(title: 'MoneyTine'),
      home: const SplashCreen(),
      //home: const HomePageScreen(),
      //home: const DropDownListExample(),
    );
  }
}
