import 'package:flutter/material.dart';

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
    return Container(
      width: double.infinity,
      height: 150,
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
        /*  borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)), */
        /*  gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.primaryColor,
            Palette.primaryColor.withOpacity(0.1),
          ],
        ), */
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
            height: 10.0,
          ),
          Text(
            '${tontine.contribution.toString()} FCFA',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Palette.whiteColor,
                fontWeight: FontWeight.w700,
                letterSpacing: -1),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
