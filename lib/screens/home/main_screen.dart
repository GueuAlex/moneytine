import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/screens/add_tontine/add_tontine.dart';
//import 'package:moneytine/screens/my_tontines/mes_tontines.dart';
import 'package:moneytine/screens/home_page/home_page.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/app_bar_actions.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/menu_button.dart';
import '../../widgets/top_banner.dart';
import 'widgets/add_tontine_error_sheet.dart';
import 'widgets/joint_tontine_error_sheet.dart';
import 'widgets/joint_tontine_sheet_contente1.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String code = '';
  String tontineName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'Acceuil',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 25,
                color: Palette.whiteColor,
                fontWeight: FontWeight.w700,
              ),
        ),
        elevation: 1,
        backgroundColor: Palette.secondaryColor,
        actions: AppBarAction.actionList,
      ),
      backgroundColor: Palette.secondaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 15.0,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: const TopBanner(),
            ),
            const SizedBox(
              height: 95,
            ),
            Expanded(
              child: Container(
                //height: MediaQuery.of(context).size.height / ,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      //width: double.,
                      margin: const EdgeInsets.only(
                        top: 50.0,
                        bottom: 18.0,
                      ),

                      /* child: Text(
                        'Menu',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.secondaryColor.withOpacity(
                                    0.9,
                                  ),
                                ),
                      ), */
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.count(
                          mainAxisSpacing: 5,
                          crossAxisCount: 3,
                          children: [
                            MunuButton(
                              text: 'Créer une tontine',
                              icon: Icons.create_new_folder,
                              onTap: () {
                                //addTontine();
                              },
                            ),
                            MunuButton(
                              text: 'Rejoindre une tontine',
                              icon: CupertinoIcons.link,
                              onTap: () {
                                rejoindreTontine(context);

                                //print(code);
                              },
                            ),
                            MunuButton(
                              text: 'Mes tontines',
                              icon: CupertinoIcons.person_3_fill,
                              onTap: () {
                                /* Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return HomePageScreen();
                                })); */
                              },
                            ),
                            /* MunuButton(
                              text: 'Mes paiements',
                              icon: CupertinoIcons.creditcard,
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const MesPaiements();
                                }));
                              },
                            ), */
                            MunuButton(
                              text: 'Parametres',
                              icon: Platform.isIOS
                                  ? CupertinoIcons.settings
                                  : Icons.settings,
                              onTap: () {},
                            ),
                            MunuButton(
                              text: ' ',
                              icon: CupertinoIcons.add,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//////////////////////////////////////// ///////////////////////////////////////
  ///
/////////////////////////////join tontine methods//////////////////////////////
  ///
///////////////////////////////////////////////////////////////////////////////

////////////////////////////////// main method/////////////////////////////////
  /// call to show alert dialog
  ///
  rejoindreTontine(BuildContext context) {
    return Platform.isIOS ? isoInputDialog(context) : androidAlert();
  }

//////////////////////////////// android alert main methode////////////////////
  /// call to show android alert methods
  ///
  Future<dynamic> androidAlert() {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'ok',
      confirmBtnColor: Palette.secondaryColor,
      customAsset: 'assets/images/logo.jpg',
      //customAsset: 'assets/custom.gif',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Code',
          prefixIcon: Icon(
            Icons.tag,
          ),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        onChanged: (value) => code = value,
      ),

      onConfirmBtnTap: () async {
        if (code.length < 5) {
          await androidErrorAlert();
          return;
        }
        Navigator.pop(context);
        await Future.delayed(const Duration(microseconds: 1000));
        // ignore: use_build_context_synchronously
        await androidSuccessAlert();
      },

      title: 'Rejoindre une tontine\n',
      text: 'Veuillez entrer le code de la tontine pour rejoindre\n',
    );
  }

  ///////////////////////////////////android success alert////////////////////
  ///
  ///
  Future<dynamic> androidSuccessAlert() {
    return QuickAlert.show(
      confirmBtnText: 'Rejoindre',
      showCancelBtn: true,
      cancelBtnText: 'Annuler',
      title: '',
      confirmBtnColor: Palette.secondaryColor,
      context: context,
      type: QuickAlertType.success,
      //text: "the code '$code' has been saved!.",
      onConfirmBtnTap: () {
        Navigator.pop(context);
        /*  Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePageScreen();
        })); */
      },
      widget: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              leading: CircleAvatar(
                child: Image.asset('assets/images/cochon.jpg'),
              ),
              title: const Text('Nom de la tontine'),
              subtitle: const Text('Créé par Mme KONAN le 01 Mars 2023'),
            )
          ],
        ),
      ),
    );
  }

  ///////////////////android error alert ///////////////////////////
  /// call on join tontine
  ///
  Future<dynamic> androidErrorAlert() {
    return QuickAlert.show(
      context: context,
      confirmBtnColor: Palette.secondaryColor,
      confirmBtnText: 'Retour',
      title: 'erreur',
      type: QuickAlertType.error,
      text: 'Ce code n\'existe pas ou n\'est plus valide !',
    );
  }

//////////////////////// ISO input dialog /////////////////////////////////////
  /// call to show cupertino input dialog
  ///
  Future<List<String>?> isoInputDialog(BuildContext context) {
    return showTextInputDialog(
      useRootNavigator: true,
      context: context,
      textFields: [
        DialogTextField(
          keyboardType: TextInputType.number,
          validator: (value) {
            //print(value!);
            //print('ok');
            if (value!.isNotEmpty) {
              _showBottomSheet(context, value);
            }
            return null;
          },
        )
      ],
      barrierDismissible: false,
      cancelLabel: 'Annuler',
      title: 'Rejoindre une tontine',
      message:
          'Pour rejoindre une tontine veuillez entrer le code de la tontine',
    );
  }

  ///////////////////////// IOS bottom sheet ///////////////////////////////////
  /// call to show botto sheet on iso ///////// can use on android too
  ///
  void _showBottomSheet(BuildContext context, String code) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: code.length >= 5
                ? const JointTontineSheetContent1()
                : const JointTontineErrorSheet(),
          );
        });
  }

//////////////////////////////////////// ///////////////////////////////////////
  ///
/////////////////////////////add tontine methods//////////////////////////////
  ///
///////////////////////////////////////////////////////////////////////////////

////////////////////////////////// main method/////////////////////////////////
// call ton add
//
  /* addTontine() {
    return Platform.isIOS
        ? isoInputDialogaddTontine(context)
        : addTontineAndroidAlert();
  } */

  //////////////////////////////// android alert main methode////////////////////
  /// call to show android alert methods
  ///
  /*  Future<dynamic> addTontineAndroidAlert() {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Suivant',
      confirmBtnColor: Palette.secondaryColor,
      customAsset: 'assets/images/logo.jpg',
      //customAsset: 'assets/custom.gif',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'tontine_dateDuJour',
          prefixIcon: Icon(
            CupertinoIcons.person_3,
          ),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onChanged: (value) => tontineName = value,
      ),

      onConfirmBtnTap: () async {
        if (tontineName.isNotEmpty && tontineName.length < 3) {
          await addAndroidErrorAlert();
          return;
        }
        Navigator.pop(context);
        await Future.delayed(const Duration(microseconds: 1000));
        // ignore: use_build_context_synchronously
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddTontineScreen(
                tontineName:
                    tontineName.isNotEmpty ? tontineName : 'tontine_dateDuJour',
              );
            },
            fullscreenDialog: true));
      },
      title: 'Créer une tontine\n',
      text:
          'Veuillez entrer un nom pour la tontine\n\nLe nom sera «tontine_dateDuJour» si le champ est vide',
    );
  } */

  ///////////////////android error alert ///////////////////////////
  /// call on create tontine
  ///
  Future<dynamic> addAndroidErrorAlert() {
    return QuickAlert.show(
      context: context,
      confirmBtnColor: Palette.secondaryColor,
      confirmBtnText: 'Retour',
      title: 'erreur',
      type: QuickAlertType.error,
      text: 'Ce nom est trop court ou est déjà pris !',
    );
  }

  //////////////////////// ISO input dialog /////////////////////////////////////
  /// call to show cupertino input dialog on add tontine
  ///
  /* Future<List<String>?> isoInputDialogaddTontine(BuildContext context) {
    return showTextInputDialog(
      useRootNavigator: true,
      context: context,
      textFields: [
        DialogTextField(
          keyboardType: TextInputType.text,
          validator: (value) {
            //print(value!);
            tontineName = value!;
            //print('ok');
            if (tontineName.isNotEmpty && tontineName.length < 3) {
              //Navigator.pop(context);
              _showBottomSheetError(context);
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddTontineScreen(
                      tontineName: tontineName.isNotEmpty
                          ? tontineName
                          : 'tontine_dateDuJour',
                    );
                  },
                  fullscreenDialog: true));
              //Navigator.pop(context);
            }
          },
        )
      ],
      barrierDismissible: false,
      cancelLabel: 'Annuler',
      title: 'Créer une tontine',
      message:
          'Veuillez entrer un nom pour la tontine\nLe nom par defaut sera «tontine_dateDuJour» si le champ est vide',
    );
  } */

  ///////////////////////// IOS bottom sheet ///////////////////////////////////
  /// call to show botto sheet on iso wen add tontine as error
  /// ///////// can use on android too
  ///
  void _showBottomSheetError(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const AddTontineErrorSheet(),
          );
        });
  }
}
