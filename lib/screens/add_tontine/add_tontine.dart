import 'dart:io';
import 'dart:math';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/widgets/custom_button.dart';
import 'package:intl/intl.dart';

import '../../style/palette.dart';
import '../../widgets/custom_text.dart';
import 'widgets/add_tontine_sheet_content.dart';

class AddTontineScreen extends StatefulWidget {
  const AddTontineScreen({Key? key, required this.tontineName})
      : super(key: key);
  final String tontineName;

  @override
  _AddTontineScreenState createState() => _AddTontineScreenState();
}

class _AddTontineScreenState extends State<AddTontineScreen> {
  /// This is list of city which will pass to the drop down.
  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(name: 'Mensuel'),
    SelectedListItem(name: 'Journalier', isSelected: false),
    SelectedListItem(name: 'Hebdomadaire', isSelected: false),
  ];

  /// This is register text field controllers.
  final TextEditingController _selectedTypeController = TextEditingController();
  final TextEditingController _numberOfController = TextEditingController();
  final TextEditingController _contributeAmountController =
      TextEditingController();

  String _selectedType = '';

  @override
  void dispose() {
    super.dispose();
    _selectedTypeController.dispose();
  }

  DateTime _selectedDate1 = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  //DateTime _selectedDate = DateTime.now();

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
                    initialDateTime: _selectedDate1,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        _selectedDate1 = newDate;
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
        initialDate: _selectedDate1,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != _selectedDate1) {
        setState(() {
          _selectedDate1 = picked;
        });
      }
    }
  }

  Future<void> _dateSelector2(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext builder) {
          return Container(
            color: const Color.fromARGB(183, 255, 255, 255),
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
                    initialDateTime: _selectedDate2,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        _selectedDate2 = newDate;
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
        initialDate: _selectedDate2,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != _selectedDate2) {
        setState(() {
          _selectedDate2 = picked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //////////////////// select type form field ///////////////////////////////
    ///
    final selectedField = TextFormField(
      controller: _selectedTypeController,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        onTextFieldTap();
      },
      validator: (value) {
        if (_selectedType.isEmpty) {
          return 'Veuillez selectionner un type de tontine';
        }
      },
      decoration: InputDecoration(
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          //color: Palette.appPrimaryColor,
        ),
        contentPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText:
            _selectedType.isNotEmpty ? _selectedType : 'Selectionner un type',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    ///////////// number of type field ///////////////////
    final numberOfField = TextFormField(
      controller: _numberOfController,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un nombre !");
        }

        return null;
      },
      onSaved: (value) {
        _numberOfController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        /* suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.appPrimaryColor,
        ), */
        contentPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText: _selectedType == 'Mensuel'
            ? 'Entrer un nombre de mois'
            : _selectedType == 'Journalier'
                ? 'Entrer un nombre de jours'
                : _selectedType == 'Hebdomadaire'
                    ? 'Entrer un nombre de semaines'
                    : '',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    ///////////// contribute amount field ///////////////////
    final contributeAmountField = TextFormField(
      controller: _contributeAmountController,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un montant !");
        }

        return null;
      },
      onSaved: (value) {
        _contributeAmountController.text = value!;
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

        hintText: 'Entrer un montant de contribution',
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: Platform.isIOS ? true : false,
        backgroundColor: Palette.primaryColor,
        title: Text(widget.tontineName),
        actions: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(
              right: 8.0,
              bottom: 8.0,
              top: 4.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.primaryColor.withOpacity(0.3),
            ),
            child: const Icon(CupertinoIcons.check_mark),
          )
        ],
      ),
      body: SafeArea(
        child: _mainBody(
          _selectedType,
          selectedField,
          //_dateSelector1,
          numberOfField,
          contributeAmountField,
        ),
      ),
    );
  }

  /// This is Main Body widget.
  Widget _mainBody(
    String type,
    TextFormField selectedField,
    //Future<void> Function(BuildContext context) selectDate,
    TextFormField numberOfField,
    TextFormField contributeAmounteField,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const CustomText(
              text: 'Completer les informations',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(
              height: 25.0,
            ),
            ////////////////////////////////////////////////////////////////////////////////
            /////////////
            ////////////////////////////////////// eall textFormField here ///////////////
            ////////////
            ///////////////////////////////////////////////////////////////////////////////
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Type',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                selectedField,
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //////////////////////////////// number of type field //////////////////////////
            type.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Nombre',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      numberOfField,
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 15.0,
            ),
            ///////////////////////////////// both tow date selector///////////////////////:
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Débute le',
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
                              _selectedDate1 != DateTime.now()
                                  ? Text(DateFormat('dd / MM / yyyy')
                                      .format(_selectedDate1))
                                  : const Text('Date de début'),
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
                        text: 'Date limite prémier paiement',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      InkWell(
                        onTap: () => _dateSelector2(context),
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
                              _selectedDate2 != DateTime.now()
                                  ? Text(DateFormat('dd / MM / yyyy')
                                      .format(_selectedDate2))
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
            const SizedBox(
              height: 25.0,
            ),
            /////////////////////////////////////////////////contribute field //////////////
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Montant de cotisation',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                contributeAmounteField,
              ],
            ),
            //////////////////////////////// ////////////////
            ////////////////////////////////////////////////////////////////////////////////
            /////////////
            //////////// ////////////////////////// end of textFormField ///////////////////
            ////////////
            ///////////////////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 25.0,
            ),
            CustomButton(
                color: Palette.appPrimaryColor,
                width: double.infinity,
                height: 45,
                radius: 50.0,
                text: 'Enregistrer la tontine',
                onPress: () {
                  //print(_selectedType.isEmpty);
                  print('type : ${_selectedType}');
                  print('nombre type : ${_numberOfController.text}');
                  print(
                      'Date debut : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedDate1)}');
                  print(
                      'Premier paie : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedDate2)}');

                  print('montant : ${_contributeAmountController.text}');
                  print(DateTime.now());

                  double amount =
                      double.parse(_contributeAmountController.text);
                  var part = (amount * (1 / 2));
                  print(part.toString());

                  _showBottomSheet(context);
                }),
          ],
        ),
      ),
    );
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Types',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _listOfCities.isNotEmpty ? _listOfCities : [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              setState(() {
                _selectedType = list[0];
              });
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showBottomSheet(BuildContext context) {
    int uniqueCode = Random().nextInt(999999);
    DateTime dateDernierPaie =
        calculerDateFin(_selectedDate2, int.parse(_numberOfController.text));
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: AddTontineSheetContent(
              tontineName: widget.tontineName,
              type: _selectedType,
              monbreType: double.parse(_numberOfController.text),
              dateDebut: _selectedDate1,
              datePremierePaie: _selectedDate2,
              dateDernierPaie: dateDernierPaie,
              amount: double.parse(
                _contributeAmountController.text,
              ),
              uniqueCode: uniqueCode,
            ),
          );
        });
  }

  DateTime calculerDateFin(DateTime dateDebut, int nombreMois) {
    // Ajouter le nombre de mois à la date de début
    DateTime dateFin = dateDebut.add(Duration(days: (30 * nombreMois)));
    //dateDebut.add(duration)

    // Vérifier si la date de fin est valide
    if (dateFin.month > (dateDebut.month + nombreMois) % 12) {
      dateFin = DateTime(dateDebut.year, dateDebut.month + nombreMois + 1, 0);
    }

    return dateFin;
  }
}
