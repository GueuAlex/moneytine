import 'package:flutter/material.dart';
import 'package:moneytine/intro.dart';
import 'package:moneytine/main.dart';
import 'package:moneytine/style/palette.dart';

class SplashCreen extends StatefulWidget {
  const SplashCreen({super.key});

  @override
  State<SplashCreen> createState() => _SplashCreenState();
}

class _SplashCreenState extends State<SplashCreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        //return const MyHomePage(title: 'MoneyTine');
        return const IntroScreen();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Palette.whiteColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.jpg'),
                const SizedBox(
                  height: 30.0,
                ),
                Image.asset('assets/icons/loading.gif')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
