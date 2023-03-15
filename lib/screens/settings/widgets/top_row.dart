import 'package:flutter/material.dart';

import '../../../style/palette.dart';
import '../../../widgets/custom_text.dart';
import 'name_container.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 140,
          height: 200,
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Palette.whiteColor,
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo.jpg'),
                ),
                border: Border.all(
                  width: 5,
                  color: Palette.appPrimaryColor.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                CustomText(
                  text: 'Prénoms',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                NameContainer(
                  text: 'Koffi Franck',
                ),
                SizedBox(
                  height: 25.0,
                ),
                CustomText(
                  text: 'Nom de famille',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                NameContainer(
                  text: 'KOUAMÉ',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
