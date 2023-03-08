import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';

class AddTontineErrorSheet extends StatelessWidget {
  const AddTontineErrorSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 13.0, top: 20.0, bottom: 20.0),
            margin: const EdgeInsets.only(top: 20.0, bottom: 15.0),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                    width: 4, color: Palette.appPrimaryColor.withOpacity(0.3))),
            child: SvgPicture.asset(
              'assets/icons/error.svg',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Ce nom est trop ou déjà pris !',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Palette.appPrimaryColor,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 15.0,
              left: 15.0,
            ),
            child: CustomButton(
                color: Palette.primaryColor,
                width: double.infinity,
                height: 45,
                radius: 50.0,
                text: 'Quitter',
                onPress: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
          )
        ],
      ),
    );
  }
}
