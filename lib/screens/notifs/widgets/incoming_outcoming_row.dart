import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class IncomingOutcomingRow extends StatelessWidget {
  const IncomingOutcomingRow({
    super.key,
  });

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
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Palette.appSecondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    CupertinoIcons.arrow_up,
                    color: Palette.appSecondaryColor,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Paiement',
                      style: TextStyle(
                        // fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FittedBox(
                      child: Text(
                        '150000 FCFA',
                        style: TextStyle(
                          fontSize: 20,
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
                borderRadius: BorderRadius.circular(10.0),
                color: Palette.primaryColor.withOpacity(0.1)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(13.0),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Palette.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    CupertinoIcons.arrow_down,
                    color: Palette.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Reception',
                      style: TextStyle(
                        //fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Text(
                        '150000 FCFA',
                        style: TextStyle(
                          fontSize: 20,
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
