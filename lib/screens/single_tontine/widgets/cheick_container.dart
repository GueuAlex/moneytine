import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class CheickContainer extends StatelessWidget {
  const CheickContainer({
    super.key,
    required this.text1,
    required this.text2,
    required this.numberOf,
  });

  final String text1;
  final String text2;
  final String numberOf;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          /*  border: Border(
          right: BorderSide(width: 1, color: Colors.grey),
        ), */
          ),
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
                        color: Colors.black.withOpacity(0.6), fontSize: 17),
                  ),
                ],
              ),
              Text(
                '      $text1',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
