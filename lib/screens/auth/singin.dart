import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/screens/auth/login.dart';
import 'package:moneytine/screens/auth/otp_screen.dart';
import 'package:moneytine/screens/auth/widgets/singin_text_field.dart';
import 'package:moneytine/style/palette.dart';

import '../../widgets/logo_container.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({super.key});

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  /////////////////////// controllers/////////////////////////////////
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }), (route) => false);
            },
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.chevron_back,
                  color: Palette.blackColor,
                  size: 25,
                ),
                Text(
                  'connexion',
                  style: TextStyle(
                    color: Palette.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            var code = await Functions.postEmail(
              api: 'users/verification/email',
              email: emailController.text,
            );

            if (code == 422) {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(
                  msg: 'Cette adresse email existe déjà',
                  backgroundColor: Palette.appPrimaryColor);
            } else if (code == 0) {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(
                  msg: 'Veuillez réessayer plutard',
                  backgroundColor: Palette.appPrimaryColor);
            } else {
              Future.delayed(const Duration(seconds: 4)).then((value) {
                User user = User(
                    fullName: firstNameController.text,
                    email: emailController.text,
                    password: passwordController.text);
                setState(() {
                  isLoading = false;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OtpScreen(
                    otp: code,
                    user: user,
                    email: emailController.text,
                  );
                }));
              });
            }
          }
        }, // Icon to display on the button
        backgroundColor: Palette.secondaryColor.withOpacity(0.9),
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
      body: Stack(
        children: [
          /* Container(
            width: double.infinity,
            height: 150,
            color: Palette.appPrimaryColor,
          ), */
          SafeArea(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const LogoContainer(),
                  Form(
                    key: _formKey,
                    child: SinginTextField(
                      firstNameController: firstNameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                            //fullscreenDialog: true,
                          ),
                        );
                      },
                      child: const Text(
                        'J\'ai déjà un compte',
                        style: TextStyle(
                          color: Palette.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
