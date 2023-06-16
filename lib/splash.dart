import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';

import 'config/prefs.dart';
import 'intro.dart';
import 'models/user.dart';
import 'remote_services/remote_services.dart';
import 'screens/auth/login.dart';
import 'screens/auth/pin_code/pin_code.dart';

class SplashCreen extends StatefulWidget {
  const SplashCreen({super.key});

  @override
  State<SplashCreen> createState() => _SplashCreenState();
}

class _SplashCreenState extends State<SplashCreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      /* print(await Prefs().id);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        //return const MyHomePage(title: 'MoneyTine');
        return const IntroScreen();
      })); */
      //print('intro is view: ${await Prefs().introIsView}');
      //print('loger id: ${await Prefs().id}');

      if (await Prefs().id == null && await Prefs().introIsView == null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          //return const MyHomePage(title: 'MoneyTine');
          return const IntroScreen();
        }));
      } else if (await Prefs().id == null &&
          await Prefs().introIsView == true) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          //return const MyHomePage(title: 'MoneyTine');
          return const LoginScreen();
        }));
      } else if (await Prefs().id != null &&
          await Prefs().introIsView == true) {
        int id = await Prefs().id;
        var response = await RemoteServices().getSingleUser(id: id);
        // ignore: use_build_context_synchronously
        if (response != null) {
          MyUser user = response;
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                //return const MyHomePage(title: 'MoneyTine');
                return PinCodeScreen(
                  user: user,
                );
              },
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            //return const MyHomePage(title: 'MoneyTine');
            return const LoginScreen();
          }));
        }
      }
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
