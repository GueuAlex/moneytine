import 'package:flutter/material.dart';

import '../../../models/tontine.dart';

class ContributionInfos extends StatelessWidget {
  const ContributionInfos({super.key, required this.tontine});
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('Contribution :'),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                '${tontine.contribution} FCFA',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Container(
            width: 20,
          ),
          Row(
            children: [
              const Text('Contirbution de type '),
              Text(tontine.type),
            ],
          )
        ],
      ),
    );
  }
}
