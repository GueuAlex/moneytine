import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/screens/single_groupe/widgets/add_user_to_group.dart';
import 'package:moneytine/style/palette.dart';

import 'widgets/groupe_membres_list.dart';
import 'widgets/groupe_screen_header.dart';

class SingleGroupeScreen extends StatelessWidget {
  const SingleGroupeScreen({
    super.key,
    required this.tontine,
    required this.groupe,
    required this.groupeColor,
  });
  final Tontine tontine;
  final Groupe groupe;
  final Color groupeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: FloatingActionButton(onPressed: () {}),
      //floatingActionButtonLocation: FloatingActionButtonLocation.,
      appBar: AppBar(
        backgroundColor: groupeColor,
        title: Text('${tontine.tontineName} / ${groupe.nom}'),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 5.0,
              right: 10.0,
              bottom: 5.0,
              left: 5.0,
            ),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Palette.blackColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                //print('add new membre to this groupe');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddUserToGroupe(
                        groupColor: groupeColor,
                        groupe: groupe,
                        tontine: tontine,
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.person_add),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  GroupeScreenHeader(
                    groupeColor: groupeColor,
                    groupe: groupe,
                    tontine: tontine,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GroupeMembersList(
                        tontine: tontine,
                        groupe: groupe,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
