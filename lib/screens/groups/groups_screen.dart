import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/style/palette.dart';

import 'widgets/single_tontine_groupe_container.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    super.key,
    required this.tontine,
    required this.user,
  });
  final Tontine tontine;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text(
          'Groupes',
          style: TextStyle(color: Palette.whiteColor),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const GroupHeader(),
            Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Expanded(
                  child: SingleTontineGroupeContainer(
                    tontine: tontine,
                    user: user,
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 55.0, left: 55.0, top: 45),
              child: GroupTopBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupHeader extends StatelessWidget {
  const GroupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(200, 10),
          bottomLeft: Radius.elliptical(200, 10),
        ),
      ),
    );
  }
}

class GroupTopBox extends StatelessWidget {
  const GroupTopBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
