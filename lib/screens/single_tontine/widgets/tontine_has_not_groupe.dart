import 'package:flutter/material.dart';

class TontineHasNotGroup extends StatelessWidget {
  const TontineHasNotGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5.0,
      ),
      margin: const EdgeInsets.only(
        bottom: 12.0,
        top: 10.0,
      ),
      width: double.infinity,
      child: const Center(
        child: Text(
          'Cette tontine ne comporte aucun groupe actuelement. Veuillez générer un groupe',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.3),
        ),
      ),
    );
  }
}
