import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(
              top: 6.0,
              left: 8.0,
              right: 5.0,
            ),
            decoration: BoxDecoration(
                color: Palette.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2023',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Palette.blackColor.withOpacity(0.3),
                  ),
                ),
                const FittedBox(
                  child: Text(
                    '20 Fev - 20 Mars',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 8.0,
            top: 8.0,
            bottom: 8.0,
          ),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          width: 150,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Palette.greyColor.withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                '1 Mois',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Palette.primaryColor,
                ),
              ),
              Icon(
                CupertinoIcons.arrowtriangle_down_fill,
                size: 15,
              )
            ],
          ),
        )
      ],
    );
  }
}
