import 'package:flutter/cupertino.dart';
import 'package:moneytine/functions/functions.dart';

import '../../../style/palette.dart';

class IncomingOutcomingRow extends StatelessWidget {
  const IncomingOutcomingRow({
    super.key,
    required this.retrait,
    required this.versement,
  });
  final double versement;
  final double retrait;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: 8.0,
              bottom: 8.0,
            ),
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: BoxDecoration(
                color: Palette.appSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Palette.appSecondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    CupertinoIcons.arrow_up,
                    color: Palette.appSecondaryColor,
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paiement',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    FittedBox(
                      child: Text(
                        '${Functions.addSpaceAfterThreeDigits(versement.toString())} FCFA',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              right: 8.0,
              bottom: 8.0,
            ),
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Palette.primaryColor.withOpacity(0.1)),
            child: Row(
              children: [
                Container(
                  //padding: const EdgeInsets.all(13.0),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Palette.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    CupertinoIcons.arrow_down,
                    color: Palette.primaryColor,
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reception',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    FittedBox(
                      child: Text(
                        '${Functions.addSpaceAfterThreeDigits(retrait.toString())} FCFA',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
