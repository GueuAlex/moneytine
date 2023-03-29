import 'package:flutter/material.dart';

import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';
import 'group_user_contribution.dart';
import 'register_user_versement.dart';

class MemberInfosContainer extends StatelessWidget {
  const MemberInfosContainer({
    super.key,
    required this.groupe,
    required this.tontine,
    required this.user,
  });
  final Tontine tontine;
  final Groupe groupe;
  final User user;

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
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              user.fullName,
              style: const TextStyle(
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
            text1: 'Gain après retrait:',
            text2: '${(70000 * groupe.membrsId.length)} FCFA',
            //onTap: () {},
          ),
          rowInfos(
            text1: 'Statut de retrait :',
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
                return GroupUserContribution(groupe: groupe, tontine: tontine);
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
                text: 'Faire un retrait',
                onPress: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
              color: Palette.appSecondaryColor,
              width: double.infinity,
              height: 45,
              radius: 50,
              text: 'Enregistrer un versement',
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RegisterUserVersement(
                      groupe: groupe, tontine: tontine);
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
