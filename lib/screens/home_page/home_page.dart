import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/screens/my_tontines/mes_tontines.dart';
import 'package:moneytine/screens/notifs/notifs_screen.dart';
import 'package:moneytine/screens/settings/settings_screen.dart';
import 'package:moneytine/style/palette.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../add_tontine/add_tontine.dart';
import '../home/widgets/add_tontine_error_sheet.dart';
import '../home/widgets/joint_tontine_error_sheet.dart';
import '../home/widgets/joint_tontine_sheet_contente1.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  //PersistentTabController _controller;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  //inal double iconSize = 22;
  String code = '';
  String tontineName = '';

  List<Widget> _buildScreens(BuildContext context) {
    return [
      const MesTontinesScreen(),
      const NotifsScreen(),
      const SettingsScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.money_dollar_circle,
          //size: iconSize,
          size: 22,
        ),
        title: "Mes tontines",
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        activeColorPrimary: Palette.appPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: [
            const Icon(
              CupertinoIcons.bell,
              size: 22,
            ),
            Positioned(
                right: 3,
                top: 5,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ))
          ],
        ),
        title: "Notifications",
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        activeColorPrimary: Palette.appPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.settings,
          //size: iconSize,
          size: 22,
        ),
        title: "Parametres",
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        activeColorPrimary: Palette.appPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        /* floatingActionButton: SpeedDial(
          //animationCurve: Curves.easeInCirc,
          overlayColor: Palette.blackColor,
          overlayOpacity: 0.3,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              onTap: () {
                addTontine();
              },
              child: const Icon(
                Icons.create_new_folder,
                color: Palette.whiteColor,
              ),
              label: 'Créer une tontine',
              labelBackgroundColor: Palette.primaryColor.withOpacity(0.9),
              labelStyle: const TextStyle(color: Palette.whiteColor),
              backgroundColor: Palette.primaryColor,
            ),
            SpeedDialChild(
              onTap: () {
                rejoindreTontine(context);
              },
              child: const Icon(
                CupertinoIcons.person_3,
                color: Palette.whiteColor,
              ),
              label: 'Rejoindre une tontine',
              labelBackgroundColor: Palette.primaryColor.withOpacity(0.9),
              labelStyle: const TextStyle(color: Palette.whiteColor),
              backgroundColor: Palette.primaryColor,
            ),
          ],
        ), */
        context,
        controller: _controller,
        screens: _buildScreens(context),
        items: _navBarsItems(),
        confineInSafeArea: true,

        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -1))
          ],
          //gradient: LinearGradient(colors: Colors.primaries),
          //borderRadius: BorderRadius.circular(10.0),

          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePageScreen();
        }));
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
  addTontine() {
    return Platform.isIOS
        ? isoInputDialogaddTontine(context)
        : addTontineAndroidAlert();
  }

  //////////////////////////////// android alert main methode////////////////////
  /// call to show android alert methods
  ///
  Future<dynamic> addTontineAndroidAlert() {
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
  }

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
  Future<List<String>?> isoInputDialogaddTontine(BuildContext context) {
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
  }

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
