import 'package:flutter/material.dart';
import '../style/palette.dart';

class MunuButton extends StatelessWidget {
  const MunuButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Palette.appPrimaryColor.withOpacity(0.2),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        child: Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Palette.appPrimaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: text.trim().isNotEmpty
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Palette.secondaryColor,
                size: 50,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Palette.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
