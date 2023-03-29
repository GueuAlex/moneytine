import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/style/palette.dart';

class GroupUserContribution extends StatelessWidget {
  const GroupUserContribution(
      {super.key, required this.groupe, required this.tontine});
  final Groupe groupe;
  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appPrimaryColor,
        title: Text('User name'),
      ),
      body: SafeArea(
          child: Center(
        child: Text('User contribution history in this groupe'),
      )),
    );
  }
}
