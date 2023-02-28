import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/screens/auth/login.dart';
import 'package:moneytine/screens/auth/singin.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/custom_button.dart';

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
                  color: Palette.appPrimaryColor,
                  width: 200,
                  height: 45,
                  radius: 50,
                  text: 'Commencer ici',
                  onPress: () {
                    _showBottomSheet(context);
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

  void _showBottomSheet(BuildContext context) {
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
            child: const SheetContent(),
          );
        });
  }
}

class SheetContent extends StatelessWidget {
  const SheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 70,
            height: 10,
            decoration: BoxDecoration(
              color: Palette.greyColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.5),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum quis porta tortor. Donec congue mauris nunc',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: CustomButton(
              color: Palette.appPrimaryColor,
              width: double.infinity,
              height: 45,
              radius: 50,
              text: 'Se connecter',
              onPress: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
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
              color: Palette.primaryColor,
              width: double.infinity,
              height: 45,
              radius: 50,
              text: 'S\'inscrire',
              onPress: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const SinginScreen();
                }));
              },
            ),
          )
        ],
      ),
    );
  }
}
