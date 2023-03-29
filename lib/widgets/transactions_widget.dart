import 'package:flutter/material.dart';

import '../style/palette.dart';
import 'transactions_type_container.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, top: 5.0, bottom: 0.0),
      constraints: const BoxConstraints(
        minHeight: 120,
        //maxWidth: double.infinity,
      ),
      child: Container(
        margin: const EdgeInsets.only(),
        padding: const EdgeInsets.all(
          0.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.whiteColor,
          borderRadius: BorderRadius.circular(
            0.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////////////////: date dot ///////////
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.appPrimaryColor,
                    ),
                    child: Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    '16',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    'Oct',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            /////////////////////
            const TransactionsTypeContainer(
              transactionType: 'versement',
              color: Palette.appPrimaryColor,
            ),
            //////////////////
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50.0, top: 5.0, bottom: 5.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 1.5,
              ),
            ),
            /////////////////////
            const TransactionsTypeContainer(
              transactionType: 'Reception',
              color: Palette.appSecondaryColor,
            ),
            //////////////////
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50.0, top: 5.0, bottom: 5.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 1.5,
              ),
            ),
            /////////////////////
            const TransactionsTypeContainer(
              transactionType: 'Retrait',
              color: Palette.secondaryColor,
            ),
            /////////////////
            const SizedBox(
              height: 15.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
