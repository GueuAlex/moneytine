import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../../functions/functions.dart';
import '../../../models/single_group_data.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../../widgets/generate_groupe_button.dart';
import 'Group_memb_list.dart';
import 'add_user_to_group.dart';
import 'group_card.dart';
import 'group_member_shimmer.dart';

class ListGroup extends StatefulWidget {
  const ListGroup({super.key, required this.tontine, required this.user});

  final Tontine tontine;
  final MyUser user;

  @override
  State<ListGroup> createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
  ////////////////////////// selected index //////////////////
  ///
  int seletedIndex = 0;

  //////////////////////// default selected group ///////////////////////
  ///
  Groupe selectedGroupe = Groupe(
    nom: 'nom', //cretat: DateTime.now(),
  );

  /////////////////////////////// selected group data //////////////////////
  ///
  List<SingleGroupData> selectedGroupData = [];

  @override
  void initState() {
    setState(() {
      selectedGroupe = widget.tontine.groupes[seletedIndex];
    });
    getselectedGroupData();
    super.initState();
  }

  void getselectedGroupData() async {
    List<SingleGroupData> data = await RemoteServices()
        .getSingleGroupData(seletedGroupId: selectedGroupe.id);
    if (data.isNotEmpty) {
      selectedGroupData.clear();
      for (SingleGroupData element in data) {
        setState(() {
          selectedGroupData.add(element);
        });
      }
    }

    Stream.periodic(Duration(seconds: 5)).asyncMap((_) async {
      List<SingleGroupData> periodicData = await RemoteServices()
          .getSingleGroupData(seletedGroupId: selectedGroupe.id);
      List<SingleGroupData> updatedselectedGroupData = [];
      if (periodicData.isNotEmpty) {
        selectedGroupData.clear();
        for (SingleGroupData element in periodicData) {
          updatedselectedGroupData.add(element);
        }
      }
      return updatedselectedGroupData;
    }).listen((updateList) {
      setState(() {
        selectedGroupData = updateList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Scrollbar(
                //thumbVisibility: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: 50,
                          height: 45,
                          margin: const EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            color: Palette.appPrimaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              generateGroup(
                                creatorId: widget.tontine.creatorId,
                                tontineId: widget.tontine.id,
                                userId: widget.user.id,
                              );
                            },
                            child: Container(
                              //padding: const EdgeInsets.all(8.0),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.secondaryColor,
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Palette.whiteColor,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(
                            widget.tontine.groupes.length,
                            (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  seletedIndex = index;
                                  selectedGroupe =
                                      widget.tontine.groupes[index];
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: selectedGroupe.membrsId.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          //selectedGroupe.nom,
                          '',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                        ),
                        GenerateGroupeButton(
                          text: 'Ajouter',
                          color: Palette.secondaryColor,
                          icon: CupertinoIcons.person_add,
                          onTap: () {
                            addMemberToGroupe();
                          },
                        )
                      ],
                    )
                  : Container(),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                /////////////// decommnter apres cela permet de verifier si le groupe selectionner compte des membres
                ///
                child: selectedGroupe.membrsId.isNotEmpty
                    ? Column(
                        children: List.generate(
                          ///////////:: bientot selectedGroupe.membersId.length /////////
                          ///
                          selectedGroupe.membrsId.length,
                          (index) => selectedGroupData.isEmpty
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey.shade200,
                                  highlightColor: Colors.grey.shade300,
                                  child: const GroupMemberShimmer(),
                                )
                              : GroupMembList(
                                  groupe: selectedGroupe,
                                  data: selectedGroupData[index],
                                  tontine: widget.tontine,
                                  currentUser: widget.user,
                                ),
                        ),
                      )

                    /////////////////////// decommanter apres ////////////////
                    ///
                    : Column(
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            'Veuillez ajouter des membres à ce groupe',
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          GenerateGroupeButton(
                            text: 'Ajouter',
                            color: Palette.appPrimaryColor,
                            icon: CupertinoIcons.person_add,
                            onTap: () {
                              addMemberToGroupe();
                            },
                          )
                        ],
                      ),
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
      Functions.showLoadingSheet(ctxt: context);

      String groupeName = 'Groupe_${(widget.tontine.groupes.length + 1)}';
      var response = await RemoteServices().postGeneratGroupeDetails(
        api: 'groups',
        tontineId: tontineId,
        groupeName: groupeName,
      );
      if (response != null) {
        Future.delayed(const Duration(seconds: 3)).then((value) async {
          Groupe? g = await RemoteServices().getSingleGroupe(
            groupeId: int.parse(response),
          );
          Groupe newGroupe = Groupe(
            nom: groupeName,
            id: int.parse(response),
          );
          if (g != null) {
            //print('difffff');
            setState(() {
              widget.tontine.groupes.add(g);
            });
          }
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

  addMemberToGroupe() {
    Functions.showLoadingSheet(ctxt: context);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (widget.tontine.creatorId == widget.user.id) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AddUserScreen(
                groupe: selectedGroupe,
                tontine: widget.tontine,
              );
            },
          ),
        );
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: 'Vous n\'est pas l\'administrateur de cette tontine !',
          backgroundColor: Palette.appPrimaryColor,
        );
      }
    });
  }
}
