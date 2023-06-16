import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../functions/functions.dart';
import '../../../models/group_with_tontine_data.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';

class StatusSheet extends StatelessWidget {
  const StatusSheet({
    super.key,
    required this.uersList,
    required this.tontine,
  });
  final List<MyUser> uersList;
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Palette.greyColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(' '),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  uersList.length,
                  (index) => UserWidget(
                    user: uersList[index],
                    tontine: tontine,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.user,
    required this.tontine,
  });
  final MyUser user;
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          _showBottomSheet(
            context: context,
            user: user,
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
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required MyUser user,
    required Tontine tontine,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Palette.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: SearchUserInfos(
            user: user,
            tontine: tontine,
          ),
        );
      },
    );
  }
}

class SearchUserInfos extends StatefulWidget {
  const SearchUserInfos({
    super.key,
    required this.user,
    required this.tontine,
  });

  final MyUser user;
  final Tontine tontine;

  @override
  State<SearchUserInfos> createState() => _SearchUserInfosState();
}

class _SearchUserInfosState extends State<SearchUserInfos> {
  ////////////////////////////////
  ///
  ///
  List<GroupWithTontineData> _data = [];
  List<int> idList = [];
  String groupsName = 'Pas de groupe';
  ///////////////////////////////
  ///
  ///
  @override
  void initState() {
    _getGroupWithTontineData();
    super.initState();
  }

  void _getGroupWithTontineData() async {
    List<GroupWithTontineData> gwtd =
        await RemoteServices().getGroupWithTontineData();
    for (GroupWithTontineData element in gwtd) {
      if (element.tontineData.id == widget.tontine.id) {
        _data.add(element);
      }
    }
    for (GroupWithTontineData element in _data) {
      for (int id in element.memberIds) {
        if (id == widget.user.id) {
          setState(() {
            groupsName = element.groupName;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Palette.greyColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.5),
            child: Text(
              ' ',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: rowInfos(
              text1: 'Nom',
              text2: Functions.nameFormater(
                fullName: widget.user.fullName,
                isFirstname: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: rowInfos(
              text1: 'Prénoms',
              text2: Functions.nameFormater(
                fullName: widget.user.fullName,
                isFirstname: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: rowInfos(
              text1: 'Email',
              text2: widget.user.email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: rowInfos(
              text1: 'Groupe',
              text2: groupsName,
            ),
          )
        ],
      ),
    );
  }

  Padding rowInfos({
    required String text1,
    required String text2,
    bool isHistory = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text1),
          !isHistory
              ? Text(
                  text2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              : TextButton(
                  onPressed: onTap,
                  child: Container(
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Palette.appPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Voir',
                        style: TextStyle(
                          color: Palette.appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
