import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class GenerateGroupeButton extends StatelessWidget {
  const GenerateGroupeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
          ),
          height: 45,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Palette.greyColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.arrow_2_circlepath_circle,
                size: 35,
                color: Palette.appPrimaryColor,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                'Générer un groupe'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Palette.appPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
