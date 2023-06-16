import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/firebase_const.dart';
import '../../config/prefs.dart';
import '../../functions/functions.dart';
import '../../models/user.dart';
import '../../style/palette.dart';
import '../../widgets/logo_container.dart';
import 'pin_code/pin_code.dart';
import 'singin.dart';
import 'widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //////////////////////// controllers ////////////////////////////////////////
  ///
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /////////////////form key ////////////////////////////
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  ///////////////////// bools //////////////////////////
  ///
  bool isLoading = false;

  //////////////////////////
  ///
  @override
  void initState() {
    passwordController.text = FirebaseConst.laraPwd;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          leading: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const SinginScreen();
              }));
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Platform.isIOS
                      ? CupertinoIcons.chevron_back
                      : CupertinoIcons.arrow_left,
                  color: Palette.blackColor,
                  size: 25,
                ),
                const Text(
                  'inscription',
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
            if (await Functions.postLoginDetails(
                    email: emailController.text,
                    password: passwordController.text) !=
                null) {
              MyUser logUser = await Functions.postLoginDetails(
                email: emailController.text,
                password: passwordController.text,
              );

              //print('dans login id : ${logUser.id}');
              //////////////////////////// a mettre en commentaire plutard ////
              ///
              await Prefs().setId(logUser.id);
              int id = await Prefs().id;
              //print(' prefs id : $id');
              //////////////////////////////////////////////////////////////
              Future.delayed(const Duration(seconds: 4)).then((value) async {
                setState(() {
                  isLoading = false;
                });
                /////////////////////////// authentification vers firestore////
                ///
                await _auth
                    .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: FirebaseConst.authPwd,
                    )
                    .then((uid) => {})
                    .catchError((e) async {
                  Fluttertoast.showToast(msg: await e!.message);
                });

                ///
                ///////////////////////////////////////////////////////////////

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return PinCodeScreen(
                    user: logUser,
                  ); //
                }), (route) => false);
              });
            } else {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(
                msg: 'Email ou mot de passe incorrect',
                backgroundColor: Palette.appPrimaryColor,
              );
            }
          }
          /*  */
          // Do something when the button is pressed
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
                    child: LoginTextField(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const SinginScreen();
                            },
                            //fullscreenDialog: true,
                          ),
                        );
                      },
                      child: const Text(
                        'Je n\'ai pas de compte',
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
