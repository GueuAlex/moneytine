import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/screens/my_tontines/widgets/jorganise_tontine_card.dart';
import 'package:moneytine/style/palette.dart';

import '../../single_tontine/single_tontine.dart';

class Jorganise extends StatelessWidget {
  const Jorganise({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('J\'organise'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              tontineList.length,
              (index) => JorganiseTontineCard(
                tontine: tontineList[index],
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SingleTontine(tontine: tontineList[index]);
                  }));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
