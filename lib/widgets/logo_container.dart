import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      //margin: const EdgeInsets.only(top: 20.0),
      foregroundDecoration: const BoxDecoration(
          //color: Colors.red,
          image: DecorationImage(
              image: AssetImage('assets/images/logo.jpg'), fit: BoxFit.cover)),
    );
  }
}
