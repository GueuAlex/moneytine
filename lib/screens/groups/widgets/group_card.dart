import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/tontine.dart';
import '../../../style/palette.dart';

class GroupeCard extends StatelessWidget {
  const GroupeCard({
    super.key,
    required this.groupe,
    required this.tontine,
    required this.selectedIndex,
    required this.index,

    // required this.onTap,
  });
  final Groupe groupe;
  final Tontine tontine;
  final int selectedIndex;
  final int index;

  //final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 5.0,
        right: 5.0,
      ),
      margin: const EdgeInsets.only(right: 5.0),
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        color: index != selectedIndex
            ? Palette.secondaryColor.withOpacity(0.2)
            : Palette.appPrimaryColor,
        /* border: Border.all(
          width: 1,
          color: Groupe.colorList[colorIndex],
        ), */
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                '${groupe.membrsId.length}/${tontine.numberOfType}',
                style: TextStyle(
                  color: selectedIndex != index
                      ? Palette.secondaryColor
                      : Palette.whiteColor,
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
                style: TextStyle(
                  color: selectedIndex != index
                      ? Palette.secondaryColor
                      : Palette.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Icon(
                CupertinoIcons.person_3_fill,
                color: selectedIndex != index
                    ? Palette.secondaryColor
                    : Palette.whiteColor,
                size: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
