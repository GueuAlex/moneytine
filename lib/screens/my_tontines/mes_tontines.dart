import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/screens/my_tontines/widgets/create_tontine_sheet_content.dart';
import 'package:moneytine/screens/my_tontines/widgets/jeparticipe.dart';
import 'package:moneytine/widgets/custom_button.dart';

import '../../style/palette.dart';
import 'widgets/jorganise.dart';
import 'widgets/last_transaction_container.dart';
import 'widgets/tontines_large_buttons.dart';

class MesTontinesScreen extends StatelessWidget {
  const MesTontinesScreen({
    super.key,
  });
  void _showBottomSheet(BuildContext context, bool isCreateTontine) {
    showBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CreatetontineSheetContent(
            isCreatTontine: isCreateTontine,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: false,
          shadowColor: Palette.greyColor,
          backgroundColor: Palette.secondaryColor,
          elevation: 0,
          title: Text(
            'MoneyTine',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Palette.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 4.0,
                ),
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                  color: Palette.secondaryColor,
                ),
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec arcu magna. Nullam sagittis condimentum mauris',
                  style: TextStyle(color: Palette.whiteColor),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TontinesLargeButton(
                          smalTxet: 'Les tontines aux quelles vous participez',
                          text: 'Vous participez à 3 tontines',
                          icon: CupertinoIcons.money_dollar,
                          backgroundColor: Palette.appPrimaryColor,
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const JeParticipe();
                            }));
                          },
                        ),
                        TontinesLargeButton(
                          smalTxet: 'Les tontines que vous organisez',
                          text: 'Vous organisez 5 tontines',
                          icon: CupertinoIcons.money_dollar_circle_fill,
                          backgroundColor: Palette.primaryColor,
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Jorganise();
                            }));
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: FittedBox(
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                    color: Palette.appPrimaryColor,
                                    width: 200,
                                    height: 45,
                                    radius: 50,
                                    text: 'Créer une tontine',
                                    onPress: () {
                                      _showBottomSheet(context, true);
                                    }),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                CustomButton(
                                    color: Palette.primaryColor,
                                    width: 200,
                                    height: 45,
                                    radius: 50,
                                    text: 'Rejoindre une tontine',
                                    onPress: () {
                                      _showBottomSheet(context, false);
                                    })
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: LastTransactions(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18.0),
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is Lorem Ipsum?',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 20,
                  letterSpacing: -1,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Palette.greyColor,
                  fontSize: 16,
                ),
          )
        ],
      ),
    );
  }
}
 */