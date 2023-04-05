import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/config/prefs.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/screens/auth/login.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/custom_button.dart';
import 'package:moneytine/widgets/custom_text.dart';

import 'widgets/name_container.dart';
import 'widgets/top_row.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.user});
  final User user;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //////////////////// notif autorisation ////////////
  bool isAllow = true;

  ///////////////:::::/// date de naissance //////////////
  ///
  DateTime birthDate = DateTime(2100);

  ////////////////////// date de naissance from Prefs()////////////
  ///
  String? birthDateFromPrefs;
  ///////////////////////////// selected option////////////////////
  ///
  String? _selectedOption;

/////////////////////////////////// list option/////////////////////
  ///
  final List<String> _options = [
    'Homme',
    'Femme',
    'Autre',
  ];

  @override
  void initState() {
    _getGender();
    _getBirthdate();
    super.initState();
  }

  void _getGender() async {
    if (await Prefs().gender != null) {
      String gender = await Prefs().gender;
      setState(() {
        _selectedOption = gender;
      });
    }
  }

  void _getBirthdate() async {
    if (await Prefs().birthdate != null) {
      String birthDate1 = await Prefs().birthdate;
      setState(() {
        birthDateFromPrefs = birthDate1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('Parametres'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopRow(user: widget.user),
              const CustomText(
                text: 'email',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              NameContainer(text: widget.user.email),
              const SizedBox(
                height: 25.0,
              ),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Date de naissance',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
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
                                    width: 1, color: Palette.whiteColor),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                birthDateFromPrefs == null
                                    ? Text(
                                        'Aucune',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Palette.blackColor
                                              .withOpacity(0.5),
                                        ),
                                      )
                                    : birthDateFromPrefs != null
                                        ? Text(
                                            birthDateFromPrefs.toString(),
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.blackColor
                                                  .withOpacity(0.6),
                                            ),
                                          )
                                        : Text(
                                            DateFormat('dd / MM / yyyy')
                                                .format(birthDate),
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.blackColor
                                                  .withOpacity(0.6),
                                            ),
                                          ),
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
                      children: const [
                        /* const CustomText(
                          text: 'Selectinner le genre',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Palette.whiteColor),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildDropDown(),
                                const Icon(Icons.arrow_drop_down),
                              ]),
                        ), */
                        SizedBox(
                          height: 50,
                          width: 200,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Autoriser les notifications',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    //color: Palette.greyColor,
                  ),
                  Switch.adaptive(
                      activeColor: Palette.appPrimaryColor,
                      value: isAllow,
                      onChanged: (bool newValue) {
                        setState(() {
                          isAllow = newValue;
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              CustomButton(
                isSetting: true,
                fontsize: 14,
                color: Palette.appPrimaryColor,
                width: double.infinity,
                height: 40,
                radius: 50,
                text: 'Enregistrer les modifications',
                onPress: () async {
                  await Prefs().setGender(gender: _selectedOption);
                  if (birthDate != DateTime(2100)) {
                    await Prefs().setBithDate(
                      birthdate: DateFormat('dd / MM / yyyy').format(birthDate),
                    );
                  }
                  Fluttertoast.showToast(
                    msg: 'Enregistrées !',
                    backgroundColor: Palette.appPrimaryColor,
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                isSetting: true,
                fontsize: 14,
                color: Palette.primaryColor,
                width: double.infinity,
                height: 40,
                radius: 50,
                text: 'Se déconnecter',
                onPress: () async {
                  Functions.showLoadingSheet(ctxt: context);
                  //////////// if (await _sigout()) { commenter //////////////
                  if (await _sigout()) {
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'À bientôt',
                        backgroundColor: Palette.appPrimaryColor,
                      );
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }), (route) => false);
                    });
                  }
                  ///////////////////// } commenter ///////////////
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _sigout() async {
    if (await Prefs().removeId()) {
      return true;
    }
    return false;
  }

//////////////////// gender selector //////////////////////
  ///
  DropdownButton<String> buildDropDown() {
    return DropdownButton<String>(
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.white,
      value: _selectedOption,
      underline: Container(),
      hint: Text(
        'Aucun',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Palette.blackColor.withOpacity(0.6),
        ),
      ),
      onChanged: (newValue) {
        setState(() {
          _selectedOption = newValue;
        });
      },
      items: _options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(
            option,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Palette.blackColor.withOpacity(0.6),
            ),
          ),
        );
      }).toList(),
    );
  }

  ///////////////////: date selector /////////////////////////
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
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        birthDate = newDate;
                        birthDateFromPrefs =
                            DateFormat('dd / MM/ yyyy').format(newDate);
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
        locale: const Locale('fr', 'FR'),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != birthDate) {
        setState(() {
          birthDate = picked;
        });
      }
    }
  }
}
