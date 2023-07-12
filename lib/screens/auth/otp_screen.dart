import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/firebase_const.dart';
import '../../functions/functions.dart';
import '../../models/user.dart';
import '../../remote_services/remote_services.dart';
import '../../style/palette.dart';
import '../../widgets/leading.dart';
import 'login.dart';
import 'pin_code/pin_code.dart';
import 'reset_password_screen.dart';
import 'widgets/otp_text_field.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  OtpScreen({
    super.key,
    required this.otp,
    required this.email,
    this.user,
    this.isSiginProcess = true,
  });
  int otp;
  final String email;
  final MyUser? user;
  final bool isSiginProcess;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController textEditingController = TextEditingController();

  bool isLoading = false;
  bool canPush = false;
  int userEntryOtp = 0;
  bool isNewOptProcess = false;

  /////////////////////////// fire base auth instance //////////////////////
  ///
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Palette.whiteColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            if (textEditingController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Code invalide',
                  backgroundColor: Palette.appPrimaryColor);
            } else {
              setState(() {
                userEntryOtp = int.parse(textEditingController.text);
              });
            }
            //print(' dans screen : $userEntryOtp');
            Future.delayed(const Duration(seconds: 4)).then((value) async {
              if (widget.otp == userEntryOtp) {
                setState(() {
                  isLoading = false;
                });
                //print(' ici : ${await postUser()}');
                if (widget.isSiginProcess) {
                  if (await Functions.postUser(user: widget.user) != null) {
                    //////////////// if user is register in our db
                    ///let add user in firebase
                    ///
                    await _auth
                        .createUserWithEmailAndPassword(
                          email: widget.email,
                          password: FirebaseConst.authPwd,
                        )
                        .then((value) => {
                              Functions.postDetailToFiresotre(
                                email: widget.email,
                                fullName: widget.user!.fullName,
                                password: FirebaseConst.authPwd,
                              )
                            })
                        .catchError((e) {
                      Fluttertoast.showToast(msg: e!.message);
                    });

                    ///
                    ///////////////////////////////////////////////////////
                    ///

                    /*  */
                    // ignore: use_build_context_synchronously
                    /*    */
                    var response = await Functions.postLoginDetails(
                      email: widget.user!.email,
                      password: widget.user!.password!,
                    );
                    if (response != null) {
                      MyUser user = response;
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return PinCodeScreen(
                          isRegistration: true,
                          user: user,
                        );
                      }), (route) => false);
                    }
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(
                      msg: 'Cette adresse email existe déjà !',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                } else {
                  // reset process
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ResetPasswordScreen(email: widget.email);
                      },
                    ),
                  );
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(
                  msg: 'Code invalide',
                  backgroundColor: Palette.appPrimaryColor,
                );
              }
            });

            // Do something when the button is pressed
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
                width: double.infinity,
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
                      child: widget.isSiginProcess
                          ? const Text(
                              'Pour continuer, veuillez entrer le code de vérification reçu par email',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Palette.whiteColor),
                            )
                          : const Text(
                              'Pour continuer, veuillez entrer le code OTP reçu par email',
                              textAlign: TextAlign.center,
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
                    padding: const EdgeInsets.only(top: 50.0),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Palette.whiteColor,
                      borderRadius: BorderRadius.only(
                          //topLeft: Radius.circular(90),
                          ),
                    ),
                    child: Column(
                      children: [
                        OteTextField(
                          textEditingController: textEditingController,
                          email: widget.email,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text('Vous n\'avez pas reçu le code ?'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          height: 40,
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            left: 8.0,
                          ),
                          decoration: BoxDecoration(
                              color: Palette.secondaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                isNewOptProcess = true;
                              });
                              int newOtp = await Functions.postEmail(
                                api: widget.isSiginProcess
                                    ? 'users/verification/email'
                                    : 'users/email/password/reset',
                                email: widget.email,
                              );
                              Future.delayed(const Duration(seconds: 4))
                                  .then((value) {
                                if (newOtp != 0) {
                                  setState(() {
                                    widget.otp = newOtp;
                                    isNewOptProcess = false;
                                  });
                                  Fluttertoast.showToast(
                                    msg: 'Code renvoyé !',
                                    backgroundColor: Palette.appPrimaryColor,
                                  );
                                } else {
                                  setState(() {
                                    isNewOptProcess = false;
                                  });
                                }
                              });
                            },
                            child: isNewOptProcess
                                ? const Text(
                                    'chargement...',
                                    style: TextStyle(
                                        color: Palette.secondaryColor),
                                  )
                                : const Text(
                                    'Renvoyer le code',
                                    style: TextStyle(
                                        color: Palette.secondaryColor),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> resendOpt({required String api, required String email}) async {
    var response = await RemoteServices().postEmail(api: api, email: email);
    if (response != null) {
      int code = int.parse(response);
      //print(' result : $code');
      return code;
    }
    return 0;
  }
}
