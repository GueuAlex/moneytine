import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';

class NotifsScreen extends StatelessWidget {
  const NotifsScreen({super.key});

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
          child: Center(
            child: Text('Notification center'),
          ),
        ),
      ),
    );
  }
}
