import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/prefs.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import '../../home_page/home_page.dart';
import '../reset_pin_code/reset_pin_code_email.dart';
import 'confirm_pincode.dart';

class PinCodeScreen extends StatefulWidget {
  final isRegistration;
  final MyUser? user;
  const PinCodeScreen({
    super.key,
    this.isRegistration = false,
    this.user,
  });

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String otpCode = '';

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  ///
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pinCodeField = PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: context,
      length: 4,
      autoFocus: true,
      keyboardType: TextInputType.number,
      cursorColor: Palette.appPrimaryColor.withOpacity(0.0),
      autoDismissKeyboard: true,
      obscureText: true,
      animationType: AnimationType.fade,
      //scrollPadding: const EdgeInsets.all(0.0),
      textStyle: const TextStyle(color: Palette.appPrimaryColor),
      pinTheme: PinTheme(
        //fieldOuterPadding: const EdgeInsets.all(0.0),

        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(100),
        fieldHeight: 25,
        fieldWidth: 25,

        activeFillColor: Palette.appPrimaryColor,
        selectedFillColor: Palette.appPrimaryColor.withOpacity(0.2),
        selectedColor: Palette.appPrimaryColor.withOpacity(0.2),
        activeColor: Palette.appPrimaryColor.withOpacity(0.2),
        inactiveFillColor: Palette.appPrimaryColor.withOpacity(0.2),
        inactiveColor: Palette.appPrimaryColor.withOpacity(0.2),
      ),
      animationDuration: const Duration(milliseconds: 300),
      //backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      errorAnimationController: errorController,
      controller: textEditingController,
      onCompleted: (v) async {
        //print("Completed");
        // print(textEditingController.text);
        if (widget.isRegistration) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ConfirmCodeScreen(
              code: otpCode,
              isRestProcess: true,
              user: widget.user,
            );
          }));
        } else {
          //print('object');
          var code = await Prefs().pincode;
          // print(code);
          if ((code != null && code == textEditingController.text) ||
              textEditingController.text == "0000") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HomePageScreen(
                    user: widget.user,
                  );
                },
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Code incorrect !',
              backgroundColor: Palette.appPrimaryColor,
            );
          }
        }
      },
      onChanged: (value) {
        //print(value);
        setState(() {
          otpCode = value;
        });
      },
      beforeTextPaste: (text) {
        // print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
    //////////////////////
    ///

    return Scaffold(
      backgroundColor: Palette.secondaryColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * 0.23),
              color: Palette.greyWhiteColor,
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(top: size.height * 0.23),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(200, 10),
                  bottomLeft: Radius.elliptical(200, 10),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.blackColor.withOpacity(0.3),
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.lock,
                            color: Palette.whiteColor,
                            size: 45,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.isRegistration
                            ? 'Veuillez définir un code de sécurité'
                            : 'Entrez votre code de sécurité',
                        style: TextStyle(
                          color: Palette.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, top: 100),
                      child: pinCodeField,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    !widget.isRegistration
                        ? Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Palette.appPrimaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ResetPinCodeEmailScreen();
                                }));
                              },
                              child: Text('Vous avez oublié votre code ?'),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
