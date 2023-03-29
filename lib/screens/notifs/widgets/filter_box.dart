import 'package:flutter/material.dart';

import '../../../style/palette.dart';
import 'date_filter.dart';
import 'incoming_outcoming_row.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // déplace l'ombre vers le bas
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // déplace l'ombre vers le haut
          )
        ],
        color: Palette.whiteColor,
      ),
      child: Column(
        children: const <Widget>[
          Expanded(
            child: DateFilter(),
          ),
          Expanded(
            child: IncomingOutcomingRow(),
          )
        ],
      ),
    );
  }
}
