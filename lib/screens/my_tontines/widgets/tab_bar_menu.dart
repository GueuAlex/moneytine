import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class TabBarMenu extends StatelessWidget {
  const TabBarMenu({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 4.0,
      ),
      width: double.infinity,
      height: 45,
      //padding: const EdgeInsets.only(top: 13.0),
      /* decoration: BoxDecoration(
          color: Palette.appPrimaryColor.withOpacity(
            0.3,
          ),
          borderRadius: BorderRadius.circular(50.0)), */
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Palette.appPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
