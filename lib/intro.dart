import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config/prefs.dart';
import 'models/terms_and_conditions.dart';
import 'screens/auth/login.dart';
import 'screens/auth/singin.dart';
import 'style/palette.dart';
import 'widgets/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Palette.whiteColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(15.0),
                //color: Colors.red,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bienvenue dans\nMoneyTine',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 25,
                            color: Palette.secondaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Conçue pour répondre aux besoins des membres de tontines, cette application est l\'outil idéal pour gérer vos cotisations en toute simplicité et transparence.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(height: 1.2),
                    )
                  ],
                ),
              ),
              const Icon(
                CupertinoIcons.arrow_down,
                color: Palette.appPrimaryColor,
                size: 30,
              ),
              CustomButton(
                  fontsize: 16,
                  isSetting: true,
                  color: Palette.appPrimaryColor,
                  width: 200,
                  height: 35,
                  radius: 50,
                  text: 'Commencer ici',
                  onPress: () async {
                    _setIntroView();
                    _showBottomSheet(context);
                    //print(await Prefs().introIsView);
                  }),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setIntroView() async {
    await Prefs().setIntroIsView(isView: true);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
          child: const SheetContent(),
        );
      },
    );
  }
}

class SheetContent extends StatefulWidget {
  const SheetContent({super.key});

  @override
  State<SheetContent> createState() => _SheetContentState();
}

class _SheetContentState extends State<SheetContent> {
  /////////////////
  ///
  bool acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Palette.greyColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Text(
            "Termes et Conditions d'utilisation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Palette.greyColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    TermsAndConditions.termsList.length,
                    (index) => TermesWidget(
                      termsAndConditions: TermsAndConditions.termsList[index],
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 10.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: acceptTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              acceptTerms = value ?? false;
                            });
                          },
                        ),
                        Text(
                          "J'accepte les termes et conditions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: CustomButton(
                      color: acceptTerms
                          ? Palette.appPrimaryColor
                          : Palette.greyColor,
                      width: double.infinity,
                      isSetting: true,
                      fontsize: 16,
                      height: 35,
                      radius: 50,
                      text: 'Se connecter',
                      onPress: acceptTerms
                          ? () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            }
                          : () {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4.0),
                          width: 100,
                          height: 2,
                          color: Palette.greyColor,
                        ),
                        const Text(
                          'OU',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 2.0),
                          width: 100,
                          height: 2,
                          color: Palette.greyColor,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: CustomButton(
                      color: acceptTerms
                          ? Palette.primaryColor
                          : Palette.greyColor,
                      width: double.infinity,
                      isSetting: true,
                      fontsize: 16,
                      height: 35,
                      radius: 50,
                      text: 'S\'inscrire',
                      onPress: acceptTerms
                          ? () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SinginScreen();
                                  },
                                ),
                              );
                            }
                          : () {},
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TermesWidget extends StatelessWidget {
  const TermesWidget({
    super.key,
    required this.termsAndConditions,
    required this.index,
  });

  final TermsAndConditions termsAndConditions;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\u2022 ${termsAndConditions.title}',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(termsAndConditions.content),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
