import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('Parametres'),
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[TopRow()],
      )),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row();
  }
}
