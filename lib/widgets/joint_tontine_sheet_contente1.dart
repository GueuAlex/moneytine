import 'package:flutter/material.dart';

import '../style/palette.dart';
import 'custom_button.dart';

class JointTontineSheetContent1 extends StatelessWidget {
  const JointTontineSheetContent1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 15.0),
          height: 8,
          width: 60,
          decoration: BoxDecoration(
              color: Palette.greyColor,
              borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: ListTile(
            leading:
                CircleAvatar(child: Image.asset('assets/images/cochon.jpg')),
            title: const Text(
              'Nom de la tontine',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Créé par Mme Konan \t le 12 Fev 2023'),
            trailing: const Text('45 membres'),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4.0),
              height: 2,
              width: 100,
              color: Palette.greyColor,
            ),
            const Text('continuer ?'),
            Container(
              margin: const EdgeInsets.only(left: 4.0),
              height: 2,
              width: 100,
              color: Palette.greyColor,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 15.0,
            right: 15.0,
          ),
          child: CustomButton(
              color: Palette.appPrimaryColor,
              width: double.infinity,
              height: 45,
              radius: 50.0,
              text: 'Oui',
              onPress: () {}),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 15.0,
            right: 15.0,
          ),
          child: CustomButton(
              color: Palette.primaryColor,
              width: double.infinity,
              height: 45,
              radius: 50.0,
              text: 'annuler',
              onPress: () {
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }
}
