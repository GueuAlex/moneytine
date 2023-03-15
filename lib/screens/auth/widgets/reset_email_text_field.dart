import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../style/palette.dart';

class ResetEmailTextField extends StatefulWidget {
  const ResetEmailTextField({
    super.key,
    required this.emailController,
  });
  final TextEditingController emailController;

  @override
  State<ResetEmailTextField> createState() => _ResetEmailTextFieldState();
}

class _ResetEmailTextFieldState extends State<ResetEmailTextField> {
  /////////////////////// controllers/////////////////////////////////

  @override
  Widget build(BuildContext context) {
    ///////////// email field ///////////////////
    final emailField = TextFormField(
      controller: widget.emailController,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un email correct !");
        }

        //email match regEx
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("Veuillez entrer un email correct !");
        }

        return null;
      },
      onSaved: (value) {
        widget.emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.mail,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        //hintText: 'email',
        labelText: 'Email',
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
            child: emailField,
          ),
        ),
      ],
    );
  }
}
