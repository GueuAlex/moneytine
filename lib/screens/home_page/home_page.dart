import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/screens/my_tontines/mes_tontines.dart';
import 'package:moneytine/screens/notifs/notifs_screen.dart';
import 'package:moneytine/screens/settings/settings_screen.dart';
import 'package:moneytine/style/palette.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, this.user});
  final MyUser? user;

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
    if (widget.user != null) {
      return [
        MesTontinesScreen(user: widget.user!),
        NotifsScreen(user: widget.user!),
        SettingsScreen(user: widget.user!)
      ];
    }
    return [];
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
}
