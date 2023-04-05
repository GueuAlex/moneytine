import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../style/palette.dart';
import '../../widgets/leading.dart';
import 'login.dart';

class SucessScreen extends StatelessWidget {
  const SucessScreen({
    super.key,
    this.isSiginProcess = true,
  });
  final bool isSiginProcess;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Palette.whiteColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Do something when the button is pressed
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }), (route) => false);
          }, // Icon to display on the button
          backgroundColor: Palette.secondaryColor,
          child: const Icon(
            CupertinoIcons.chevron_right,
            color: Palette.whiteColor,
          ), // Background color of the button
        ),
        appBar: AppBar(
          backgroundColor: Palette.secondaryColor,
          leadingWidth: 120,
          leading: CustomLeading(
              contextColor: Palette.whiteColor,
              text: 'connexion',
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }), (route) => false);
              }),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Palette.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(200, 10),
                    bottomLeft: Radius.elliptical(200, 10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 18, 42)
                            .withOpacity(0.2),
                        shape: BoxShape.circle,
                        //border: Border.all(width: 1, color: Colors.white)
                      ),
                      child: const Icon(
                        CupertinoIcons.check_mark,
                        color: Palette.whiteColor,
                        size: 45,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        right: 8.0,
                        left: 8.0,
                      ),
                      child: isSiginProcess
                          ? const Text(
                              'Votre compte a bien été créer !',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Palette.whiteColor),
                            )
                          : const Text(
                              'sucess',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Palette.whiteColor),
                            ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 100.0),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Palette.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset('assets/icons/sucess.svg'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
