import 'package:flutter/cupertino.dart';

import '../../../style/palette.dart';
import '../../../widgets/generate_groupe_button.dart';

class TontineHasNotGroup extends StatelessWidget {
  const TontineHasNotGroup({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

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
      child: Center(
        child: Column(
          children: [
            const Text(
              'Cette tontine ne comporte aucun groupe.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.3,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            GenerateGroupeButton(
              text: 'Créer un groupe',
              color: Palette.appPrimaryColor,
              icon: CupertinoIcons.arrow_2_circlepath,
              onTap: onTap,
              isGenerate: true,
            ),
          ],
        ),
      ),
    );
  }
}
