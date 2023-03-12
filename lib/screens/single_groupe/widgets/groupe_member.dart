import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneytine/screens/single_groupe/widgets/register_user_paiement.dart';
import 'package:moneytine/screens/single_groupe/widgets/single_groupe_user_contribution.dart';
import 'package:moneytine/widgets/custom_button.dart';

import '../../../models/tontine.dart';
import '../../../style/palette.dart';

class GroupeMember extends StatelessWidget {
  const GroupeMember({
    super.key,
    required this.groupe,
    required this.tontine,
  });
  final Tontine tontine;
  final Groupe groupe;
  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Retirer',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: CupertinoIcons.arrow_2_circlepath,
            label: 'Paiement',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.

      // The child of the Slidable is what the user sees when the
      // component is not dragged.

      child: ListTile(
        onTap: () {
          print('object');
          memberInfos(context);
        },
        leading: CircleAvatar(
          child: Image.asset('assets/images/cochon.jpg'),
        ),
        title: const Text('User name'),
        subtitle: Text('Contribution ${tontine.type} : 70000 FCFA'),
        trailing: const Icon(
          CupertinoIcons.chevron_right,
          size: 16,
        ),
      ),
    );
  }

  memberInfos(BuildContext context) {
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
            ),
          );
        });
  }
}

class MemberInfosContainer extends StatelessWidget {
  const MemberInfosContainer({
    super.key,
    required this.groupe,
    required this.tontine,
  });
  final Tontine tontine;
  final Groupe groupe;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5.0,
              bottom: 15.0,
            ),
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'User name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          rowInfos(
            text1: 'Part de contribution :',
            text2: '70000 FCFA',
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Gain à la retribution :',
            text2: '${(70000 * groupe.membrsId.length)} FCFA',
            //onTap: () {},
          ),
          rowInfos(
            text1: 'Statut de la retribution :',
            text2: 'Effectuée',
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Historique des contributions :',
            text2: 'Voir',
            isHistory: true,
            onTap: () {
              // print('contribution historique ');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SingleGroupeUserContributions(
                    groupe: groupe, tontine: tontine);
              }));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
                color: Palette.appPrimaryColor,
                width: double.infinity,
                height: 45,
                radius: 50,
                text: 'Faire une retribution',
                onPress: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
              color: Palette.appSecondaryColor,
              width: double.infinity,
              height: 45,
              radius: 50,
              text: 'Enregistrer un paiement',
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RegisterUserPaiement(groupe: groupe, tontine: tontine);
                }));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
                color: Palette.greyColor,
                width: double.infinity,
                height: 45,
                radius: 50,
                text: 'Retirer ce membre',
                onPress: () {}),
          ),
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
