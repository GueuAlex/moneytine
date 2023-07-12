import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/single_group_data.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import 'member_infos_container.dart';

class GroupMembList extends StatefulWidget {
  const GroupMembList({
    super.key,
    required this.groupe,
    //required this.user,
    required this.data,
    required this.tontine,
    required this.currentUser,
  });

  final Groupe groupe;
  //final User user;
  final Tontine tontine;
  final SingleGroupData data;
  final MyUser currentUser;

  @override
  State<GroupMembList> createState() => _GroupMembListState();
}

class _GroupMembListState extends State<GroupMembList> {
  MyUser user = MyUser(fullName: '', email: '', isActive: 1);
  @override
  void initState() {
    getUser();
    //
    super.initState();
  }

  getUser() async {
    MyUser? apiUser = await RemoteServices().getSingleUser(id: widget.data.id);
    if (apiUser != null) {
      setState(
        () {
          user = apiUser;
        },
      );
    }
  }

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
            groupe: widget.groupe,
            tontine: widget.tontine,
            data: widget.data,
            currentUser: widget.currentUser,
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
        title: Text(widget.data.name),
        subtitle: Text(widget.data.email),
        trailing: const Icon(
          CupertinoIcons.chevron_forward,
        ),
      ),
    );
  }

  memberInfos({
    required BuildContext context,
    required MyUser user,
    required Tontine tontine,
    required Groupe groupe,
    required SingleGroupData data,
    required MyUser currentUser,
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
          height: MediaQuery.of(context).size.height,
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
            data: data,
            currentUser: currentUser,
          ),
        );
      },
    );
  }
}
