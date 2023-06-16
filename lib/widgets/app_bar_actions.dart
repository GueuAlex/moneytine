import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../style/palette.dart';

class AppBarAction {
  AppBarAction();

  static List<Widget>? actionList = [
    Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(
            right: 8.0,
            bottom: 8.0,
            top: 4.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.primaryColor.withOpacity(0.3),
          ),
          child: SvgPicture.asset(
            'assets/icons/bell.svg',
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 17,
          right: 25,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        )
      ],
    ),
  ];
}
