import 'package:flutter/material.dart';

import '../../../style/palette.dart';
import '../../../widgets/custom_text.dart';

class NameContainer extends StatelessWidget {
  const NameContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(right: 15.0),
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Palette.greyColor.withOpacity(0.3),
          ),
        ),
      ),
      child: CustomText(
        text: text,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Palette.blackColor.withOpacity(0.4),
      ),
    );
  }
}
