import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/models/user.dart';

import '../../../functions/functions.dart';
import '../../../style/palette.dart';
import '../widgets/reset_email_text_field.dart';
import 'reset_pin_otp_screen.dart';

class ResetPinCodeEmailScreen extends StatefulWidget {
  final MyUser user;
  const ResetPinCodeEmailScreen({super.key, required this.user});

  @override
  State<ResetPinCodeEmailScreen> createState() =>
      _ResetPinCodeEmailScreenState();
}

class _ResetPinCodeEmailScreenState extends State<ResetPinCodeEmailScreen> {
  ///////////////// email controller //////////////////////
  final TextEditingController emailController = TextEditingController();

  ///////////form key /////////////////
  final _formKey = GlobalKey<FormState>();

  //////////////////bool ////////////////
  bool isLoading = false;

  @override
  void initState() {
    emailController.text = widget.user.email;
    super.initState();
  }

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
                api: 'users/email/password/reset',
                email: emailController.text,
              );
              Future.delayed(const Duration(seconds: 3)).then((value) {
                if (code != 0) {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ResetPinOtpScreen(
                      otp: code,
                      email: emailController.text,
                      user: widget.user,
                      //isSiginProcess: false,
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
                        'Pour mettre à jour votre code de sécurité, veuillez entrer votre adresse email. Vous recevrez un code OTP par email pour créer un nouveau mot de passe.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Palette.whiteColor,
                              fontSize: 14,
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







// ignore: must_be_immutable






