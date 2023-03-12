import 'package:flutter/material.dart';
import 'package:moneytine/screens/single_groupe/widgets/groupe_member.dart';

import '../../../models/tontine.dart';

class GroupeMembersList extends StatelessWidget {
  const GroupeMembersList(
      {super.key, required this.groupe, required this.tontine});
  final Tontine tontine;
  final Groupe groupe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          groupe.membrsId.length,
          (index) => GroupeMember(
                tontine: tontine,
                groupe: groupe,
              )),
    );
  }
}
