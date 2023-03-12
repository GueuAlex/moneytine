import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class GenerateGroupeButton extends StatelessWidget {
  const GenerateGroupeButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
        ),
        height: 45,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(width: 1, color: color),
            borderRadius: BorderRadius.circular(50.0)),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: Palette.whiteColor,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              text.toLowerCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
