import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      //margin: const EdgeInsets.only(top: 20.0),
      foregroundDecoration: const BoxDecoration(
          //color: Colors.green,
          //border: Border.all(width: 2, color: Colors.black),
          image: DecorationImage(
              image: AssetImage('assets/images/logo.jpg'), fit: BoxFit.cover)),
    );
  }
}
