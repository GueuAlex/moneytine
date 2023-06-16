import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../functions/functions.dart';
import '../../style/palette.dart';
import '../../widgets/leading.dart';
import 'login.dart';
import 'success.dart';
import 'widgets/reset_password_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ///////////////////// controller /////////////////////////////////
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //////////////// form key ////////////////////////
  final _formKey = GlobalKey<FormState>();

  ////////////////bool ////////////////////////
  bool isLoading = false;

  ////////////dispose() controllers /////////////////
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
            // Do something when the button is pressed
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              if (await Functions.resetPassword(
                      email: widget.email, password: passwordController.text) !=
                  null) {
                Future.delayed(const Duration(seconds: 4)).then((value) {
                  setState(() {
                    isLoading = false;
                  });
                });
                Fluttertoast.showToast(
                  msg: 'Mot de passe réinitialiser',
                  backgroundColor: Palette.appPrimaryColor,
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SucessScreen(
                    isSiginProcess: false,
                  );
                }));
              } else {
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(
                  msg: 'Veuillez réessayer plutard',
                  backgroundColor: Palette.appPrimaryColor,
                );
              }
            }
            /* ; */
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
                width: double.infinity,
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
                        CupertinoIcons.lock,
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
                        'Renseignez un nouveau mot de passe pour continuer',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Palette.whiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                      child: ResetPasswordTextField(
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
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
