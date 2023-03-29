import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../models/tontine.dart';
import '../../../style/palette.dart';

class GroupeScreenHeader extends StatelessWidget {
  const GroupeScreenHeader({
    super.key,
    required this.groupeColor,
    required this.groupe,
    required this.tontine,
  });

  final Color groupeColor;
  final Groupe groupe;
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 8.0,
        left: 8.0,
        top: 8.0,
        bottom: 20.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              groupeColor,
              groupeColor.withOpacity(0.1),
            ],
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'montant soldé'.toUpperCase(),
                        style: const TextStyle(
                            color: Palette.whiteColor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: 250,
                        height: 45,
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          left: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: groupeColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              '${((tontine.contribution * groupe.membrsId.length) * (0.70)).round()} FCFA',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Palette.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    FittedBox(
                      child: CircularPercentIndicator(
                        radius: 50,
                        animation: true,
                        animationDuration: 1000,
                        lineWidth: 15,
                        percent: 0.7,
                        center: const Text(
                          '70%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.whiteColor,
                          ),
                        ),
                        progressColor: groupeColor,
                        backgroundColor: groupeColor.withOpacity(0.1),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Prgression du premier paiement',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: groupeColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
