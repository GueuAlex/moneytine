import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/widgets/custom_button.dart';

import '../../../style/palette.dart';
import '../../../widgets/custom_text.dart';

class RegisterUserPaiement extends StatefulWidget {
  const RegisterUserPaiement({
    super.key,
    required this.groupe,
    required this.tontine,
  });
  final Groupe groupe;
  final Tontine tontine;

  @override
  State<RegisterUserPaiement> createState() => _RegisterUserPaiementState();
}

class _RegisterUserPaiementState extends State<RegisterUserPaiement> {
  /////////////////////////////// text editing controllers////////////////////
  ///paiement note controller
  ///paiement amount controller
  final TextEditingController _paimentNoteCotroller = TextEditingController();
  final TextEditingController _paiementAmountController =
      TextEditingController();

  ///////////////////////// paimemnt date & paiment time //////////////////////
  ///
  DateTime _selectedPaimentDate = DateTime.now();
  TimeOfDay _selectedPaimentTime = TimeOfDay.now();

  ////////////////////////// disposer les controllers /////////////////////
  ///
  @override
  void dispose() {
    super.dispose();
    _paimentNoteCotroller.dispose();
    _paiementAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ////////////// paiment amount amount field ///////////////////
    final paiementAmountField = TextFormField(
      controller: _paiementAmountController,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un montant !");
        }

        return null;
      },
      onSaved: (value) {
        _paiementAmountController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        /* suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.appPrimaryColor,
        ), */
        contentPadding: EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText: 'Entrer un montant de paiement',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    ////////////// paiment note  field ///////////////////
    final paiementNoteField = TextFormField(
      controller: _paimentNoteCotroller,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (value) {
        if (value!.isNotEmpty && value.length < 3) {
          return ("Veuillez correctement renseigner la note !");
        }

        return null;
      },
      onSaved: (value) {
        _paimentNoteCotroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        /* suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.appPrimaryColor,
        ), */
        contentPadding: EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText: 'Entrer une note de paiement (Facultif)',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appSecondaryColor,
        title: Text('User name'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              const CustomText(
                text: 'Enregistrer un paiement pour',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              const CustomText(
                text: 'This user name',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 25.0,
              ),
              const CustomText(
                text: 'Note',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: paiementNoteField,
              ),

              ///////////////////// date & hours field ////////////////////
              ///
              ///
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Date',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        InkWell(
                          onTap: () {
                            _dateSelector1(context);
                            //_selectDate(context);
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Palette.greyColor),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _selectedPaimentDate != DateTime.now()
                                    ? Text(DateFormat('dd / MM / yyyy')
                                        .format(_selectedPaimentDate))
                                    : const Text('Date de paiement'),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Heure',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        InkWell(
                          onTap: () => _timeSelector(context),
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Palette.greyColor),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _selectedPaimentTime != TimeOfDay.now()
                                    ? Text(
                                        DateFormat('HH : mm ').format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        _selectedPaimentTime.hour,
                                        _selectedPaimentTime.minute,
                                      )))
                                    : const Text('Date limite'),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /////////////// and /////////////////////
              ///
              const SizedBox(
                height: 20.0,
              ),
              const CustomText(
                text: 'Montant du paiement',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: paiementAmountField,
              ),

              CustomButton(
                color: Palette.appSecondaryColor,
                width: double.infinity,
                height: 45,
                radius: 50,
                text: 'Enregistrer le paimenet',
                onPress: () {
                  print(_selectedPaimentTime);
                },
              )
            ],
          ),
        ),
      ),
    );
    ;
  }

  //////////////////////////// date selector switch platform///////////////////
  ///
  Future<void> _dateSelector1(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            color: CupertinoColors.quaternarySystemFill,
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Annuler',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: _selectedPaimentDate,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        _selectedPaimentDate = newDate;
                        print(newDate.toString());
                      });
                    },
                    minimumYear: 1900,
                    maximumYear: 2100,
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedPaimentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != _selectedPaimentDate) {
        setState(() {
          _selectedPaimentDate = picked;
        });
      }
    }
  }

  ////////////////////////// time selector ////////////////////////////////
  ///
  Future<void> _timeSelector(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _selectedPaimentTime,
    );
    if (newTime != null) {
      setState(() {
        _selectedPaimentTime = newTime;
      });
    }
  }
}
