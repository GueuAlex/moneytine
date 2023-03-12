//import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/style/palette.dart';

import 'widgets/list_groupe_card_header.dart';
import 'widgets/single_tontine_groupe_container.dart';
import 'widgets/single_tontine_header.dart';

//import 'widgets/export_widgets.dart';

class SingleTontine extends StatelessWidget {
  const SingleTontine({super.key, required this.tontine});
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: Text(tontine.tontineName),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SingleTontineHeader(tontine: tontine),
            SingleTontineGroupeContainer(tontine: tontine),
            const Expanded(child: SingleTontineMembersContainer())
          ],
        ),
      ),
    );
  }
}

class SingleTontineMembersContainer extends StatelessWidget {
  const SingleTontineMembersContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 2.0),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        // bottom: 20.0,
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
        children: [
          const ListGroupCardHeader(
              text: 'Liste des membres', icon: CupertinoIcons.person_3_fill),
          Container(
            //height: 8.0,
            width: double.infinity,
            margin: const EdgeInsets.only(
              bottom: 10.0,
              top: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Nom cmplet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Adresse email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            //flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: List.generate(
                  8,
                  (index) => TontineMembersList(),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TontineMembersList extends StatelessWidget {
  TontineMembersList({
    super.key,
  });
  final int colorIndex = Random().nextInt(9);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: Palette.greyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      /////// faire un condition ici plutard pour voir s'il des membres //////
      /// child : Row()
      ///
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'This tontine user name',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            'exemple@gmail.com',
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
