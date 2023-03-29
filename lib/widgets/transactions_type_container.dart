import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style/palette.dart';

class TransactionsTypeContainer extends StatelessWidget {
  const TransactionsTypeContainer({
    super.key,
    required this.transactionType,
    required this.color,
  });
  final String transactionType;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      transactionType,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28),
              child: Text(
                DateFormat('HH:mm').format(DateTime.now()),
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 28.0,
          ),
          child: Text(
            'Tontine name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 8.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.person_fill,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'This user name',
                      style: TextStyle(color: Palette.greyColor),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28.0),
              child: Container(
                padding: const EdgeInsets.only(
                  right: 2.0,
                  left: 2.0,
                ),
                width: 70,
                height: 25,
                decoration: BoxDecoration(
                  color: Palette.greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Center(
                  child: FittedBox(
                    child: Text(
                      '5000000 FCFA',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 2.0,
        )
      ],
    );
  }
}
