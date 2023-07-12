import 'package:flutter/material.dart';

class CheickContainer extends StatelessWidget {
  const CheickContainer({
    super.key,
    required this.text1,
    required this.text2,
    required this.numberOf,
    required this.paddingLeft,
    required this.paddingRigth,
    required this.onTap,
  });

  final String text1;
  final String text2;
  final String numberOf;
  final double paddingLeft;
  final double paddingRigth;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    numberOf,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                '      $text1',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
          /* Container(
            height: 28,
            width: 28,
            decoration: const BoxDecoration(
              color: Palette.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.right_chevron,
                color: Colors.white,
                size: 17,
              ),
            ),
          ) */
          Container()
        ],
      ),
    );
  }
}
