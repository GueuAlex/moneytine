import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/style/palette.dart';

import 'widgets/group_header.dart';
import 'widgets/group_top_box.dart';
import 'widgets/single_tontine_groupe_container.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    super.key,
    required this.tontine,
    required this.user,
  });
  final Tontine tontine;
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
