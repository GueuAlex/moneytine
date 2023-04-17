import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class GroupHeader extends StatelessWidget {
  const GroupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(200, 10),
          bottomLeft: Radius.elliptical(200, 10),
        ),
      ),
    );
  }
}
