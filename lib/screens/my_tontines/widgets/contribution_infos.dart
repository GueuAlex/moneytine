import 'package:flutter/material.dart';

class ContributionInfos extends StatelessWidget {
  ContributionInfos({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Container(
      margin: const EdgeInsets.only(right: 4.0),
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
      //width: 110,
      height: 30,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: color),
        ),
      ),
    ));
  }
}
