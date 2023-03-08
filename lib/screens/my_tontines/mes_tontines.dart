import 'package:flutter/material.dart';
import 'package:moneytine/screens/my_tontines/widgets/jeparticipe.dart';

import '../../style/palette.dart';
import 'widgets/jorganise.dart';
import 'widgets/tab_bar_menu.dart';

class MesTontinesScreen extends StatelessWidget {
  const MesTontinesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: false,
          bottom: const TabBar(
              indicatorColor: Palette.appPrimaryColor,
              //unselectedLabelColor: Colors.amber,
              indicatorWeight: 4.0,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
              tabs: [
                TabBarMenu(
                  text: 'J\'organise',
                ),
                TabBarMenu(
                  text: 'Je participe',
                )
              ]),
          shadowColor: Palette.greyColor,
          backgroundColor: Palette.whiteColor,
          elevation: 3,
          title: Text(
            'MoneyTine',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Palette.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: const [
                HeaderText(),
                SizedBox(
                  height: 16.0,
                ),
                Jorganise(),
              ],
            ),
            Column(
              children: const [
                HeaderText(),
                SizedBox(
                  height: 16.0,
                ),
                JeParticipe(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
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
                  fontSize: 25,
                  letterSpacing: -2,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Palette.greyColor),
          )
        ],
      ),
    );
  }
}
