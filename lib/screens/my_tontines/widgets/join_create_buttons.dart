import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class JoinCreateButton extends StatelessWidget {
  const JoinCreateButton({
    super.key,
    required this.text,
    required this.svg,
    required this.color,
    required this.onTap,
  });

  final String text;
  final String svg;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(svg),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
