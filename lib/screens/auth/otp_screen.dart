import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../style/palette.dart';
import '../../widgets/leading.dart';
import 'login.dart';
import 'reset_password_screen.dart';
import 'widgets/otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Palette.secondaryColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ResetPasswordScreen();
            }));
            // Do something when the button is pressed
          }, // Icon to display on the button
          backgroundColor: Palette.secondaryColor,
          child: const Icon(
            CupertinoIcons.chevron_right,
            color: Palette.whiteColor,
          ), // Background color of the button
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 120,
          leading: CustomLeading(
              contextColor: Palette.whiteColor,
              text: 'Connexion',
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }), (route) => false);
              }),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 2, 18, 42).withOpacity(0.2),
                  shape: BoxShape.circle,
                  //border: Border.all(width: 1, color: Colors.white)
                ),
                child: const Icon(
                  CupertinoIcons.barcode_viewfinder,
                  color: Palette.whiteColor,
                  size: 45,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 8.0,
                  left: 8.0,
                ),
                child: const Text(
                  'Pour continuer, veuillez entrer le code OTP reçu par email',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Palette.whiteColor),
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Palette.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                      ),
                    ),
                    child: const OteTextField(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
