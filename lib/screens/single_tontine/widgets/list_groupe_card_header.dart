//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class ListGroupCardHeader extends StatelessWidget {
  const ListGroupCardHeader({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 3.0),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Palette.greyColor.withOpacity(0.5),
            ),
            //color: Palette.secondaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Icon(
            icon,
            size: 35,
            color: Palette.appPrimaryColor,
          ),
        )
      ],
    );
  }
}
