import 'dart:async';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../style/palette.dart';

class OteTextField extends StatefulWidget {
  const OteTextField({
    super.key,
    required this.textEditingController,
    required this.email,
  });
  final TextEditingController textEditingController;
  final String email;

  @override
  State<OteTextField> createState() => _OteTextFieldState();
}

class _OteTextFieldState extends State<OteTextField> {
  String otpCode = '';

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: context,
      length: 4,
      autoFocus: false,
      obscureText: false,
      animationType: AnimationType.fade,
      //scrollPadding: const EdgeInsets.all(0.0),
      textStyle: const TextStyle(color: Colors.white),
      pinTheme: PinTheme(
        //fieldOuterPadding: const EdgeInsets.all(0.0),

        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Palette.appPrimaryColor,
        selectedFillColor: Palette.appPrimaryColor,
        selectedColor: Palette.appPrimaryColor,
        activeColor: Palette.appPrimaryColor.withOpacity(0.2),
        inactiveFillColor: Palette.appPrimaryColor.withOpacity(0.2),
        inactiveColor: Palette.appPrimaryColor.withOpacity(0.2),
      ),
      animationDuration: const Duration(milliseconds: 300),
      //backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      errorAnimationController: errorController,
      controller: widget.textEditingController,
      onCompleted: (v) {
        // print("Completed");
        // print(widget.textEditingController.text);
      },
      onChanged: (value) {
        //print(value);
        setState(() {
          otpCode = value;
        });
      },
      beforeTextPaste: (text) {
        //print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
