import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';

import 'widgets/filter_box.dart';
import 'widgets/notifications_list.dart';

class NotifsScreen extends StatefulWidget {
  const NotifsScreen({super.key});

  @override
  State<NotifsScreen> createState() => _NotifsScreenState();
}

class _NotifsScreenState extends State<NotifsScreen> {
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
                    right: 25,
                    left: 25,
                    top: 25,
                  ),
                  child: FilterBox(),
                ),
              ),
              Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
