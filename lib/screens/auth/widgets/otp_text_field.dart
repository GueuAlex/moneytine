import 'dart:async';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../style/palette.dart';

class OteTextField extends StatefulWidget {
  const OteTextField({super.key});

  @override
  State<OteTextField> createState() => _OteTextFieldState();
}

class _OteTextFieldState extends State<OteTextField> {
  String otpCode = '';

  TextEditingController textEditingController = TextEditingController();
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
    return Column(
      children: [
        PinCodeTextField(
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
          controller: textEditingController,
          onCompleted: (v) {
            print("Completed");
          },
          onChanged: (value) {
            print(value);
            setState(() {
              otpCode = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
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
            onPressed: () {
              print('object');
            },
            child: const Text(
              'Renvoyer le code',
              style: TextStyle(color: Palette.secondaryColor),
            ),
          ),
        )
      ],
    );
  }
}
