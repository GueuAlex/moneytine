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
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.primaryColor,
            Palette.primaryColor.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contribution ${tontine.type.toLowerCase()} de',
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
          Text(
            'Votre code d\'invitation',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Palette.whiteColor,
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Text(
                tontine.uniqueCode.toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Palette.whiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8.0,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.copy,
                  color: Palette.whiteColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
