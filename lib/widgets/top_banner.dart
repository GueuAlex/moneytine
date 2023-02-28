import 'package:flutter/material.dart';

import '../style/palette.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8.0,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Palette.blackColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset('assets/images/cochon.jpg'),
            ),
          ),
          Expanded(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'MoneyTine',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Palette.whiteColor,
                      ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Avec moneytine gérer vos tontine\nen toute simplicté !',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Palette.whiteColor,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
