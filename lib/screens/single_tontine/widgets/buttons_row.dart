import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../style/palette.dart';
import '../../../widgets/generate_groupe_button.dart';
import '../../groups/groups_screen.dart';
import '../../modify_tontine/mdify_tontine.dart';
import '../single_tontine.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    super.key,
    required this.widget,
  });

  final SingleTontine widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 5.0,
        left: 5.0,
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GenerateGroupeButton(
            icon: CupertinoIcons.pen,
            text: 'Modifier',
            color: Palette.secondaryColor,
            onTap: () {
              if (widget.tontine.creatorId == widget.user.id) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ModifyTontineScreen(
                          tontine: widget.tontine,
                          user: widget.user,
                        );
                      },
                      fullscreenDialog: true,
                    ));
              } else {
                Fluttertoast.showToast(
                  msg: 'Cette est uniquement reservée qu\'a l\'administration',
                  backgroundColor: Palette.appPrimaryColor,
                );
              }
            },
          ),
          const SizedBox(
            width: 5.0,
          ),
          GenerateGroupeButton(
            icon: CupertinoIcons.person_2,
            text: 'Groupes',
            color: Palette.primaryColor,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GroupsScreen(
                  tontine: widget.tontine,
                  user: widget.user,
                );
              }));
            },
          ),
          const SizedBox(
            width: 5.0,
          ),
          GenerateGroupeButton(
            icon: CupertinoIcons.delete,
            text: 'Supprimer',
            color: Palette.appPrimaryColor,
            onTap: () {
              print('generate groupe ici');
            },
          ),
          const SizedBox(
            width: 5.0,
          ),
          GenerateGroupeButton(
            icon: CupertinoIcons.pause_fill,
            text: 'Suspendre',
            color: Palette.appSecondaryColor,
            onTap: () {
              print('remove this groupe');
            },
          ),
        ],
      ),
    );
  }
}
