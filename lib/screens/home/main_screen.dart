import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytine/screens/auth/login.dart';
import 'package:moneytine/screens/auth/success.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/custom_button.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/joint_tontine_error_sheet.dart';
import '../../widgets/joint_tontine_sheet_contente1.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/top_banner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Palette.secondaryColor,
        actions: [
          Stack(
            children: [
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
                child: SvgPicture.asset(
                  'assets/icons/bell.svg',
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 17,
                right: 25,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
              )
            ],
          ),
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
              child: const Icon(CupertinoIcons.person_fill))
        ],
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

                      child: Text(
                        'Menu',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.secondaryColor.withOpacity(
                                    0.9,
                                  ),
                                ),
                      ),
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
                              onTap: () {},
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
                              onTap: () {},
                            ),
                            MunuButton(
                              text: 'Mes paiements',
                              icon: CupertinoIcons.creditcard,
                              onTap: () {},
                            ),
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

  rejoindreTontine(BuildContext context) {
    return Platform.isIOS
        ? showTextInputDialog(
            useRootNavigator: true,
            context: context,
            textFields: [
              DialogTextField(
                validator: (value) {
                  print(value!);
                  print('ok');
                  if (value.isNotEmpty) {
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
          )
        : androidAlert();
  }

  Future<dynamic> androidAlert() {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Save',
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
        keyboardType: TextInputType.phone,
        onChanged: (value) => code = value,
      ),

      onConfirmBtnTap: () async {
        if (code.length < 5) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Ce code n\'existe pas ou n\'est plus valide !',
          );
          return;
        }
        Navigator.pop(context);
        await Future.delayed(const Duration(microseconds: 1000));
        // ignore: use_build_context_synchronously
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "the code '$code' has been saved!.",
          onConfirmBtnTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SucessScreen();
            }));
          },
        );
      },
      title: 'Rejoindre une tontine',
      text: 'Veuillez entrer le code de la tontine pour rejoindre',
    );
  }

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
}
