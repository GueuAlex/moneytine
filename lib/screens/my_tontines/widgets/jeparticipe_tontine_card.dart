import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/style/palette.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/user.dart';
import 'contribution_infos.dart';

class JeParticipeTontineCard extends StatefulWidget {
  const JeParticipeTontineCard(
      {super.key, required this.tontine, required this.onTap});
  final Tontine tontine;
  final VoidCallback onTap;

  @override
  State<JeParticipeTontineCard> createState() => _JeParticipeTontineCardState();
}

class _JeParticipeTontineCardState extends State<JeParticipeTontineCard> {
  /////////////////////////: tontine creator ////////////////////
  ///
  ///
  MyUser? user;

  ///////////////////////////////////
  ///
  @override
  void initState() {
    getCreator();
    super.initState();
  }

  void getCreator() async {
    var response =
        await RemoteServices().getSingleUser(id: widget.tontine.creatorId);
    if (response != null) {
      setState(() {
        user = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(
        bottom: 10.0,
        right: 8.0,
        left: 8.0,
      ),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          color: Palette.whiteColor,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Palette.greyColor.withOpacity(0.3),
            ),
          )
          /* boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // déplace l'ombre vers le bas
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // déplace l'ombre vers le haut
          ),
        ], */
          ),
      child: user != null
          ? Column(
              children: [
                ListTile(
                    onTap: widget.onTap,
                    /* leading: CircleAvatar(
              child: Image.asset('assets/images/cochon.jpg'),
            ), */
                    title: Text(
                      widget.tontine.tontineName,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                                color: const Color.fromARGB(255, 104, 103, 102),
                              ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Créer le ${DateFormat('dd / MM / yyyy').format(widget.tontine.startDate)}',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.person_fill),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(user!.fullName),
                            )
                          ],
                        )
                      ],
                    ),
                    trailing: Container(
                      margin: const EdgeInsets.only(top: 13.0),
                      height: 40,
                      width: 40,
                      //color: Colors.amber,
                      decoration: const BoxDecoration(
                        color: Palette.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //ContributionInfos(label: '${tontine.contribution} FCFA'),

                        ContributionInfos(
                          label: '${widget.tontine.groupes.length} Groupes',
                          color: Palette.appSecondaryColor,
                        ),
                        ContributionInfos(
                          label: '${widget.tontine.membersId.length} Membres',
                          color: Palette.appPrimaryColor,
                        ),
                        ContributionInfos(
                          label: widget.tontine.type,
                          color: Palette.greyColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade300,
              child: ShimmerChild(
                widget: widget,
              ),
            ),
    );
  }
}

class ShimmerChild extends StatelessWidget {
  const ShimmerChild({
    super.key,
    required this.widget,
  });

  final JeParticipeTontineCard widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: widget.onTap,
            /* leading: CircleAvatar(
    child: Image.asset('assets/images/cochon.jpg'),
            ), */
            title: Container(
              height: 15,
              width: 80,
              color: Colors.grey.shade300,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 8,
                  width: 130,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.person_fill),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        height: 8,
                        width: 50,
                        color: Colors.grey.shade300,
                      ),
                    )
                  ],
                )
              ],
            ),
            trailing: Container(
              margin: const EdgeInsets.only(top: 13.0),
              height: 40,
              width: 40,
              //color: Colors.amber,
              decoration: const BoxDecoration(
                color: Palette.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.chevron_right,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            )),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ContributionInfos(label: '${tontine.contribution} FCFA'),

                ContributionInfos(
                  label: '                 ',
                  color: Palette.appSecondaryColor,
                ),
                ContributionInfos(
                  label: '                 ',
                  color: Palette.appPrimaryColor,
                ),
                ContributionInfos(
                  label: '                 ',
                  color: Palette.greyColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
