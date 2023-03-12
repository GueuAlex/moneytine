import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/palette.dart';

class TontinesLargeButton extends StatelessWidget {
  const TontinesLargeButton({
    super.key,
    required this.smalTxet,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
  });
  final String smalTxet;
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 2.0,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 40,
                    color: Palette.whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      smalTxet,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Palette.whiteColor,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Palette.whiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Palette.whiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
