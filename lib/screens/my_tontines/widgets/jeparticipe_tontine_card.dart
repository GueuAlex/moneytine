import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/style/palette.dart';

import 'contribution_infos.dart';

class JeParticipeTontineCard extends StatelessWidget {
  const JeParticipeTontineCard(
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
        borderRadius: BorderRadius.circular(10.0),
        color: Palette.whiteColor,
        boxShadow: [
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
        ],
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: CircleAvatar(
              child: Image.asset('assets/images/cochon.jpg'),
            ),
            title: Text(
              tontine.tontineName,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: const Color.fromARGB(255, 104, 103, 102),
                  ),
            ),
            subtitle: Text(
                'Créer le ${DateFormat('dd / MM / yyyy').format(tontine.startDate)}\nPar Creator name'),
            trailing: Text(
              '${tontine.membersId.length} membres',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          ContributionInfos(
            tontine: tontine,
          )
        ],
      ),
    );
  }
}
