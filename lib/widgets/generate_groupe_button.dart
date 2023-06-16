import 'package:flutter/material.dart';

import '../style/palette.dart';

class GenerateGroupeButton extends StatelessWidget {
  const GenerateGroupeButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    required this.onTap,
    this.isGenerate = false,
  });

  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isGenerate;

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
        width: isGenerate ? 160 : 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),

          ///border: Border.all(width: 1, color: color),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  icon,
                  size: 14,
                  color: Palette.whiteColor,
                ),
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
