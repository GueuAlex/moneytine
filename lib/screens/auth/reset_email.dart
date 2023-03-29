import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/screens/auth/login.dart';
import 'package:moneytine/style/palette.dart';

import '../../widgets/leading.dart';
import 'otp_screen.dart';
import 'widgets/reset_email_text_field.dart';

class ResetEmailScreen extends StatefulWidget {
  const ResetEmailScreen({super.key});

  @override
  State<ResetEmailScreen> createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  ///////////////// email controller //////////////////////
  final TextEditingController emailController = TextEditingController();

  ///////////form key /////////////////
  final _formKey = GlobalKey<FormState>();

  //////////////////bool ////////////////
  bool isLoading = false;

  //////////////
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Palette.whiteColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              int code = await Functions.postEmail(
                api: 'users/verification/email',
                email: emailController.text,
              );
              Future.delayed(const Duration(seconds: 3)).then((value) {
                if (code != 0) {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OtpScreen(
                      otp: code,
                      email: emailController.text,
                      isSiginProcess: false,
                    );
                  }));
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              });
              /*  */
            }
          }, // Icon to display on the button
          backgroundColor: Palette.secondaryColor,
          child: !isLoading
              ? const Icon(
                  CupertinoIcons.chevron_right,
                  color: Palette.whiteColor,
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Palette.secondaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ), // Background color of the button
        ),
        appBar: AppBar(
          backgroundColor: Palette.secondaryColor,
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
                decoration: const BoxDecoration(
                  color: Palette.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(200, 10),
                    bottomLeft: Radius.elliptical(200, 10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 18, 42)
                            .withOpacity(0.2),
                        shape: BoxShape.circle,
                        //border: Border.all(width: 1, color: Colors.white)
                      ),
                      child: const Icon(
                        CupertinoIcons.mail,
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
                      child: Text(
                        'Pour mettre à jour votre mot de passe, veuillez entrer votre adresse email. You will receive a OTP code via email to creat a new password',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Palette.whiteColor,
                              fontSize: 16,
                              height: 1.2,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 100.0),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Palette.whiteColor,
                      borderRadius: BorderRadius.only(
                          //topLeft: Radius.circular(90),
                          ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: ResetEmailTextField(
                        emailController: emailController,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
