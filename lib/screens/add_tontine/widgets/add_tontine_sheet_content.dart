import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/screens/home_page/home_page.dart';
import 'package:moneytine/widgets/custom_button.dart';
import 'package:moneytine/widgets/custom_text.dart';

import '../../../style/palette.dart';

class AddTontineSheetContent extends StatelessWidget {
  const AddTontineSheetContent({
    super.key,
    required this.tontineName,
    required this.type,
    required this.monbreType,
    required this.dateDebut,
    required this.datePremierePaie,
    required this.dateDernierPaie,
    required this.amount,
    required this.uniqueCode,
  });
  final String tontineName;
  final String type;
  final double monbreType;
  final DateTime dateDebut;
  final DateTime datePremierePaie;
  final DateTime dateDernierPaie;
  final double amount;
  final int uniqueCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Palette.greyColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: CustomText(
                      text: 'Récapitulatif',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        RecapInfosRow(
                          label: 'Nom :',
                          text: tontineName,
                        ),
                        RecapInfosRow(
                          label: 'Type :',
                          text: type,
                        ),
                        RecapInfosRow(
                          label: 'Nomde de mois :',
                          text: monbreType.toString(),
                        ),
                        RecapInfosRow(
                          label: 'Date de début :',
                          text: DateFormat('dd / MM / yyyy').format(dateDebut),
                        ),
                        RecapInfosRow(
                          label: 'Date du prémier paiement :',
                          text: DateFormat('dd / MM / yyyy')
                              .format(datePremierePaie),
                        ),
                        RecapInfosRow(
                          label: 'Date du dernier prémier paiement :',
                          text: DateFormat('dd / MM / yyyy')
                              .format(dateDernierPaie),
                        ),
                        RecapInfosRow(
                          label: 'Montant de cotisation :',
                          text: amount.toString(),
                        ),
                        RecapInfosRow(
                          label: 'Montant pour 1/2 part :',
                          text: demiPart(amount).toString(),
                        ),
                        RecapInfosRow(
                          label: 'Montant pour 1/4 de part :',
                          text: unQuartPart(amount).toString(),
                        ),
                        RecapInfosRow(
                          label: 'Code d\'invitation :',
                          text: uniqueCode.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), /////////////////////

            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  CustomButton(
                      color: Palette.appPrimaryColor,
                      width: double.infinity,
                      height: 45,
                      radius: 50,
                      text: 'Créer la tontine',
                      onPress: () {
                        Future.delayed(const Duration(seconds: 2)).then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) {
                                  return HomePageScreen();
                                }), (route) => false));
                      }),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomButton(
                      color: Palette.primaryColor,
                      width: double.infinity,
                      height: 45,
                      radius: 50,
                      text: 'Annuler',
                      onPress: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double demiPart(double amount) {
    return (amount * (1 / 2));
  }

  double unQuartPart(double amount) {
    return (amount * (1 / 4));
  }
}

class RecapInfosRow extends StatelessWidget {
  const RecapInfosRow({
    required this.label,
    required this.text,
    super.key,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 5.0, bottom: 3.0),
          child: Text(label),
        ),
        Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 5.0, bottom: 3.0),
            child: Text(text)),
      ],
    );
  }
}
