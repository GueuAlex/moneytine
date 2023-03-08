import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/tontine.dart';
import 'export_widgets.dart';
//import 'export_widgets.dart';

class SingleTontineGroupeContainer extends StatelessWidget {
  const SingleTontineGroupeContainer({super.key, required this.tontine});

  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 3), // déplace l'ombre vers le bas
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 3), // déplace l'ombre vers le bas
            ),
          ],
          color: Colors.white),
      child: Column(
        children: <Widget>[
          const ListGroupCardHeader(
              text: 'Liste des groupes',
              icon: CupertinoIcons.arrow_2_circlepath_circle),
          const SizedBox(
            height: 10.0,
          ),
          tontine.groupes.isNotEmpty
              ? ListGroup(tontine: tontine)
              : const TontineHasNotGroup(),
          const SizedBox(
            height: 15.0,
          ),
          const GenerateGroupeButton()
        ],
      ),
    );
  }
}
