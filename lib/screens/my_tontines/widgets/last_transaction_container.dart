import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/palette.dart';

class LastTransactions extends StatelessWidget {
  LastTransactions({
    super.key,
  });

  final List<bool> isOrgonisateur = [
    false,
    false,
    true,
    false,
    true,
    true,
    false,
    true,
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dernières  transactions',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Palette.blackColor,
                    fontSize: 12,
                  ),
            ),
            Text(
              'Tout afficher',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Palette.greyColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              10,
              (index) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(1.0),
                    margin: const EdgeInsets.only(top: 4.0),
                    decoration: BoxDecoration(
                        color: Palette.greyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: ListTile(
                      title: const Text('Tontine name\n'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('dd / MM / yyyy')
                              .format(DateTime.now())),
                          const SizedBox(
                            height: 3.0,
                          ),
                          const Text('Reception de : 370000 FCFA'),
                        ],
                      ),
                      trailing: Chip(
                          label: isOrgonisateur[index]
                              ? const Text(
                                  'Organisateur',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  'Participant',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                    ),
                  )),
        )
      ],
    );
  }
}
