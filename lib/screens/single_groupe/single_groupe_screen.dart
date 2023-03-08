import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';

class SingleGroupeScreen extends StatelessWidget {
  const SingleGroupeScreen({
    super.key,
    required this.tontine,
    required this.groupe,
  });
  final Tontine tontine;
  final Groupe groupe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Center(
        child: Text(groupe.nom),
      )),
    );
  }
}
