import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/loading_container.dart';

import 'widgets/filter_box.dart';
import 'widgets/notifications_list.dart';

class NotifsScreen extends StatefulWidget {
  const NotifsScreen({super.key});

  @override
  State<NotifsScreen> createState() => _NotifsScreenState();
}

class _NotifsScreenState extends State<NotifsScreen> {
  /////////////////////////////////////////////////////
  /// nous permet d'afficher un container de loading pendant 5 seconds le temps de charger les données ////
  bool isLoading = true;

  //////////////////////////////////////////////////////
  ///un semblant de notification data
  bool isNotificationData = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('Notifications'),
        elevation: 0,
      ),
      body: NotificationListener(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Palette.secondaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(200, 10),
                      bottomLeft: Radius.elliptical(200, 10)),
                ),
              ),
              const Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 55,
                    left: 55,
                    top: 25,
                  ),
                  child: FilterBox(),
                ),
              ),
              !isLoading
                  ? isNotificationData
                      ? Padding(
                          padding: const EdgeInsets.only(top: 160),
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                3,
                                (index) => const NotificationList(),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 250),
                          padding: const EdgeInsets.all(30),
                          width: double.infinity,
                          height: 300,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/missing_notif.jpg',
                                width: 200,
                              ),
                              Text('Pas de notifications pour le moment')
                            ],
                          ),
                        )
                  : Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: LoadingContainer(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
