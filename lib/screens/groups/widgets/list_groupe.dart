import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../style/palette.dart';
import '../../../widgets/list_groupe_card_header.dart';
import 'Group_memb_list.dart';
import 'group_card.dart';

class ListGroup extends StatefulWidget {
  const ListGroup({super.key, required this.tontine, required this.user});

  final Tontine tontine;
  final User user;

  @override
  State<ListGroup> createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
  int seletedIndex = 0;
  Groupe selectedGroupe = Groupe(
    nom: 'nom', //cretat: DateTime.now(),
  );
  @override
  void initState() {
    setState(() {
      selectedGroupe = widget.tontine.groupes[seletedIndex];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListGroupCardHeader(
              text: 'Liste des groupes',
              icon: CupertinoIcons.arrow_2_circlepath_circle,
              onTap: () {
                Functions.showLoadingSheet(ctxt: context);
                generateGroup(
                  userId: widget.user.id,
                  creatorId: widget.tontine.creatorId,
                  tontineId: widget.tontine.id,
                );
              },
              isTransaction: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(
                    widget.tontine.groupes.length,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          seletedIndex = index;
                          selectedGroupe = widget.tontine.groupes[index];
                        });
                      },
                      child: GroupeCard(
                        index: index,
                        selectedIndex: seletedIndex,
                        groupe: widget.tontine.groupes[index],
                        tontine: widget.tontine,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListGroupCardHeader(
              text: 'Groupe_1',
              icon: CupertinoIcons.person_add,
              onTap: () {
                Functions.showLoadingSheet(ctxt: context);
                print("add");
              },
              isTransaction: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              child: SizedBox(
                  width: double.infinity,
                  /////////////// decommnter apres cela permet de verifier si le groupe selectionner compte des membres
                  ///
                  child: /* selectedGroupe.membrsId.isNotEmpty
                    ? */
                      Column(
                    children: List.generate(
                      ///////////:: bientot selectedGroupe.membersId.length /////////
                      ///
                      groupMembres.length,
                      (index) => GroupMembList(
                        groupe: selectedGroupe,
                        user: groupMembres[index],
                        tontine: widget.tontine,
                      ),
                    ),
                  )

                  /////////////////////// decommanter apres ////////////////
                  ///
                  /* : Column(
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text('Veuillez ajouter des membres à groupe'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          GenerateGroupeButton(
                            text: 'Ajouter',
                            color: Palette.appPrimaryColor,
                            icon: CupertinoIcons.person_add,
                            onTap: () {},
                          )
                        ],
                      ), */
                  ),
            )
          ],
        ),
      ),
    );
  }

  //////////////////// function to generate group //////////////////////////
  ///
  ///
  ///
  void generateGroup({
    required int? userId,
    required int creatorId,
    required int tontineId,
  }) async {
    if (userId == creatorId) {
      Groupe newGroupe = Groupe(
        nom: 'Groupe_${(widget.tontine.groupes.length + 1)}',
        // cretat: DateTime.now(),
      );

      String groupeName = 'Groupe_${(widget.tontine.groupes.length + 1)}';
      var response = await RemoteServices().postGeneratGroupeDetails(
        api: 'groups',
        tontineId: tontineId,
        groupeName: groupeName,
      );
      if (response != null) {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            widget.tontine.groupes.add(newGroupe);
          });
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'Ajouté !',
            backgroundColor: Palette.appPrimaryColor,
          );
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: 'Veuillez réessayer !',
          backgroundColor: Palette.appPrimaryColor,
        );
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Vous n\'est pas l\'administrateur de cette tontine !',
        backgroundColor: Palette.appPrimaryColor,
      );
    }
  }
}
