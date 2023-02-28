import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import '../config/style.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading(
      {super.key,
      required this.text,
      required this.onTap,
      required this.contextColor});
  final String text;
  final VoidCallback onTap;
  final Color contextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Row(
          children: <Widget>[
            Icon(
              CupertinoIcons.chevron_back,
              color: contextColor,
              size: 35,
            ),
            Text(
              text.toLowerCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: contextColor,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
