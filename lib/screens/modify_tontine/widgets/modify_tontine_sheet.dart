import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/screens/single_tontine/single_tontine.dart';
import 'package:moneytine/widgets/custom_button.dart';
import 'package:moneytine/widgets/custom_text.dart';

import '../../../style/palette.dart';

class ModifyTontineSheetContent extends StatefulWidget {
  const ModifyTontineSheetContent({
    super.key,
    required this.tontineName,
    required this.type,
    required this.monbreType,
    required this.dateDebut,
    required this.datePremierePaie,
    required this.dateDernierPaie,
    required this.amount,
    required this.uniqueCode,
    required this.tontineID,
    required this.user,
    required this.tontine,
  });
  final String tontineName;
  final String type;
  final int monbreType;
  final DateTime dateDebut;
  final DateTime datePremierePaie;
  final DateTime dateDernierPaie;
  final double amount;
  final int uniqueCode;
  final int tontineID;
  final MyUser user;
  final Tontine tontine;

  @override
  State<ModifyTontineSheetContent> createState() =>
      _ModifyTontineSheetContentState();
}

class _ModifyTontineSheetContentState extends State<ModifyTontineSheetContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Palette.greyColor.withOpacity(0.7),
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
                            text: widget.tontineName.isEmpty
                                ? DateFormat('tontine_dd/MM/yyyy')
                                    .format(DateTime.now())
                                : widget.tontineName,
                          ),
                          RecapInfosRow(
                            label: 'Type :',
                            text: widget.type,
                          ),
                          RecapInfosRow(
                            label: 'Nomde de mois :',
                            text: widget.monbreType.toString(),
                          ),
                          RecapInfosRow(
                            label: 'Date de début :',
                            text: DateFormat('dd / MM / yyyy')
                                .format(widget.dateDebut),
                          ),
                          RecapInfosRow(
                            label: 'Date du prémier paiement :',
                            text: DateFormat('dd / MM / yyyy')
                                .format(widget.datePremierePaie),
                          ),
                          RecapInfosRow(
                            label: 'Date du dernier prémier paiement :',
                            text: DateFormat('dd / MM / yyyy')
                                .format(widget.dateDernierPaie),
                          ),
                          RecapInfosRow(
                            label: 'Montant de cotisation :',
                            text: widget.amount.toString(),
                          ),
                          RecapInfosRow(
                            label: 'Montant pour 1/2 part :',
                            text: demiPart(widget.amount).toString(),
                          ),
                          RecapInfosRow(
                            label: 'Montant pour 1/4 de part :',
                            text: unQuartPart(widget.amount).toString(),
                          ),
                          RecapInfosRow(
                            label: 'Code d\'invitation :',
                            text: widget.uniqueCode.toString(),
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
                      text: 'Soumettre les modifications',
                      onPress: () async {
                        Functions.showLoadingSheet(ctxt: context);
                        Tontine newTontine = Tontine(
                          id: 0,
                          uniqueCode: widget.uniqueCode,
                          tontineName: widget.tontineName,
                          type: widget.type,
                          numberOfType: widget.monbreType,
                          contribution: widget.amount,
                          startDate: widget.dateDebut,
                          firstPaiemntDate: widget.datePremierePaie,
                          creatorId: int.parse(
                            widget.user.id.toString(),
                          ),
                        );
                        int? responseId = await RemoteServices().putTontine(
                          api: 'tontines/${widget.tontineID}',
                          tontine: newTontine,
                        );

                        if (responseId != null) {
                          Tontine? tontine =
                              await RemoteServices().getSingleTontine(
                            id: responseId,
                          );
                          setState(() {
                            currentUSerTontineList.remove(widget.tontine);
                            currentUSerTontineList.add(tontine!);
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          if (tontine != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SingleTontine(
                                    tontine: tontine,
                                    user: widget.user,
                                    isFiret: true,
                                  );
                                },
                              ),
                            );
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                    ),
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
    return Container(
      width: double.infinity,
      height: 25,
      margin: const EdgeInsets.only(
        top: 2,
      ),
      padding: const EdgeInsets.only(
        right: 2.0,
        left: 10.0,
      ),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
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
      ),
    );
  }
}
