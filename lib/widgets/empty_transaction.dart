import 'package:flutter/material.dart';

class EmptyTransactios extends StatelessWidget {
  const EmptyTransactios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/empty.png'),
        const Text('Aucune trnasaction pour le moment'),
      ],
    );
  }
}
