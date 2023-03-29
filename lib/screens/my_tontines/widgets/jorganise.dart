import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/screens/my_tontines/widgets/jorganise_tontine_card.dart';
import 'package:moneytine/style/palette.dart';

import '../../single_tontine/single_tontine.dart';

class Jorganise extends StatelessWidget {
  const Jorganise({
    super.key,
    required this.tontineList,
    required this.user,
  });

  final List<Tontine> tontineList;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Palette.secondaryColor,
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        //title: const Text('3 tontines'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 65, right: 65),
                      width: double.infinity,
                      height: 100,
                      //padding: const EdgeInsets.only(right: 50, left: 50),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(200, 10),
                            bottomLeft: Radius.elliptical(200, 10)),
                        color: Palette.secondaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                tontineList.length.toString(),
                                style: const TextStyle(
                                  color: Palette.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              const Text(
                                '  Tontines',
                                style: TextStyle(
                                  color: Palette.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Palette.blackColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Center(
                              child: Text(
                                'Organisateur',
                                style: TextStyle(
                                  color: Palette.greyWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      //top: 10,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 80,
                          bottom: 10,
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            width: 300,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.0),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 1), // déplace l'ombre vers le bas
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, -1), // déplace l'ombre vers le haut
                                )
                              ],
                              color: Palette.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: List.generate(
                  tontineList.length,
                  (index) => JorganiseTontineCard(
                    tontine: tontineList[index],
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SingleTontine(
                          tontine: tontineList[index],
                          user: user,
                        );
                      }));
                    },
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
