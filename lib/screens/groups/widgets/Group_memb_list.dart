import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import 'member_infos_container.dart';

class GroupMembList extends StatelessWidget {
  const GroupMembList({
    super.key,
    required this.groupe,
    required this.user,
    required this.tontine,
  });

  final Groupe groupe;
  final User user;
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: ListTile(
        onTap: () {
          memberInfos(
            context: context,
            user: user,
            groupe: groupe,
            tontine: tontine,
          );
        },
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Palette.appPrimaryColor.withOpacity(0.1),
          ),
          child: const Center(
            child: Icon(
              CupertinoIcons.person_fill,
              size: 20,
              color: Palette.appPrimaryColor,
            ),
          ),
        ),
        title: Text(user.fullName),
        subtitle: Text(user.email),
        trailing: const Icon(
          CupertinoIcons.chevron_forward,
        ),
      ),
    );
  }

  memberInfos({
    required BuildContext context,
    required User user,
    required Tontine tontine,
    required Groupe groupe,
  }) {
    return showBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 5,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
            ),
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Palette.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: MemberInfosContainer(
              tontine: tontine,
              groupe: groupe,
              user: user,
            ),
          );
        });
  }
}
