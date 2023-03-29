import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/style/palette.dart';

import 'contribution_infos.dart';

class JorganiseTontineCard extends StatelessWidget {
  const JorganiseTontineCard(
      {super.key, required this.tontine, required this.onTap});
  final Tontine tontine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(
        bottom: 10.0,
        right: 8.0,
        left: 8.0,
      ),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          color: Palette.whiteColor,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Palette.greyColor.withOpacity(0.3),
            ),
          )
          /* boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // déplace l'ombre vers le bas
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // déplace l'ombre vers le haut
          ),
        ], */
          ),
      child: Column(
        children: [
          ListTile(
              onTap: onTap,
              /* leading: CircleAvatar(
              child: Image.asset('assets/images/cochon.jpg'),
            ), */
              title: Text(
                tontine.tontineName,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      color: const Color.fromARGB(255, 104, 103, 102),
                    ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Créer le ${DateFormat('dd / MM / yyyy').format(tontine.startDate)}',
                  ),

                  /*  Row(
                    children: const [
                      Icon(CupertinoIcons.person_fill),
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text('Creator name'),
                      )
                    ],
                  ) */
                ],
              ),
              trailing: Container(
                margin: const EdgeInsets.only(top: 13.0),
                height: 40,
                width: 40,
                //color: Colors.amber,
                decoration: const BoxDecoration(
                  color: Palette.secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ContributionInfos(label: '${tontine.contribution} FCFA'),

                  ContributionInfos(
                    label: '${tontine.groupes.length} Groupes',
                    color: Palette.appSecondaryColor,
                  ),
                  ContributionInfos(
                    label: '${tontine.membersId.length} Membres',
                    color: Palette.appPrimaryColor,
                  ),
                  ContributionInfos(
                    label: tontine.type,
                    color: Palette.greyColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
