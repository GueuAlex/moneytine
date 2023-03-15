import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class ResetPasswordTextField extends StatefulWidget {
  const ResetPasswordTextField({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController passwordController;

  final TextEditingController confirmPasswordController;

  @override
  State<ResetPasswordTextField> createState() => _ResetPasswordTextFieldState();
}

class _ResetPasswordTextFieldState extends State<ResetPasswordTextField> {
  /////////////////////// controllers/////////////////////////////////

  @override
  Widget build(BuildContext context) {
    ///////////////confirm password field/////////////
    final confirmPasswordField = TextFormField(
      controller: widget.confirmPasswordController,
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez confirmer le mot de passe !");
        }
        if (widget.confirmPasswordController.text !=
            widget.passwordController.text) {
          return ("Les mots de passe ne correspondent pas !");
        }
        //email match regEx

        return null;
      },
      onSaved: (value) {
        widget.confirmPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.lock,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        //hintText: 'email',
        labelText: 'Confirmer le mot de passe',
        labelStyle: const TextStyle(color: Palette.secondaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //////////////////// password field ///////////////
    final passwordField = TextFormField(
      controller: widget.passwordController,
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez renseigner le mot de passe !");
        }

        //email match regEx

        return null;
      },
      onSaved: (value) {
        widget.passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.lock,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        //hintText: 'email',
        labelText: 'Mot de passe',
        labelStyle: const TextStyle(color: Palette.secondaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
            left: 15.0,
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.0)),
            child: passwordField,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
            left: 15.0,
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.0)),
            child: confirmPasswordField,
          ),
        ),
      ],
    );
  }
}
