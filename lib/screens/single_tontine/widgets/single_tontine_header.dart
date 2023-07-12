import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/functions/functions.dart';

import '../../../models/tontine.dart';
import '../../../style/palette.dart';

class SingleTontineHeader extends StatelessWidget {
  const SingleTontineHeader({
    super.key,
    required this.tontine,
  });

  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    DateTime dateFin = Functions.calculerDateLimiteDernierPaiement(
      dateDebut: tontine.startDate,
      dateLimitePremierPaiement: tontine.firstPaiemntDate,
      nombreMois: tontine.numberOfType,
    );
    return Container(
      width: double.infinity,
      height: 190,
      padding: const EdgeInsets.only(
          right: 12.0, top: 12.0, bottom: 12.0, left: 50.0),
      margin: const EdgeInsets.only(
        bottom: 8.0,
      ),
      decoration: const BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.elliptical(200, 10),
            bottomLeft: Radius.elliptical(200, 10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tontine.type == 'Mensuel'
                ? 'Contribution mensuelle de'
                : tontine.type == 'Journalier'
                    ? 'Contribution journalière de'
                    : 'hebdomadaire',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Palette.whiteColor, fontSize: 16),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            //Functions.numberFormat(tontine.contribution.toString()),
            '${Functions.addSpaceAfterThreeDigits((tontine.contribution).toString())} FCFA',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Palette.whiteColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  fontSize: 23,
                ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Date de fin',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Palette.whiteColor,
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            DateFormat('dd MMM yyyy', 'fr_FR').format(dateFin),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Palette.whiteColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  fontSize: 23,
                ),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
