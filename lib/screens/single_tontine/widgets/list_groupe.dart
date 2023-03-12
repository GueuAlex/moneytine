import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/screens/single_groupe/single_groupe_screen.dart';

import '../../../models/tontine.dart';
import '../../../style/palette.dart';

class ListGroup extends StatelessWidget {
  const ListGroup({
    super.key,
    required this.tontine,
  });

  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(
            tontine.groupes.length,
            (index) => GroupeCard(
              groupe: tontine.groupes[index],
              tontine: tontine,
            ),
          ),
        ),
      ),
    );
  }
}

class GroupeCard extends StatelessWidget {
  GroupeCard({
    super.key,
    required this.groupe,
    required this.tontine,
    // required this.onTap,
  });
  final Groupe groupe;
  final Tontine tontine;

  //final VoidCallback onTap;
  final int colorIndex = Random().nextInt(9);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return SingleGroupeScreen(
              tontine: tontine,
              groupe: groupe,
              groupeColor: Groupe.colorList[colorIndex],
            );
          }),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 5.0,
          left: 5.0,
          right: 5.0,
        ),
        margin: const EdgeInsets.only(right: 5.0),
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: Groupe.colorList[colorIndex],
          border: Border.all(
            width: 1,
            color: Groupe.colorList[colorIndex],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  '${groupe.membrsId.length}/${tontine.numberOfType}',
                  style: const TextStyle(
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  groupe.nom,
                  style: const TextStyle(
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  CupertinoIcons.person_3_fill,
                  color: Palette.whiteColor,
                  size: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
