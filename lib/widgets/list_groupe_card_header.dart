//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/palette.dart';

class ListGroupCardHeader extends StatelessWidget {
  const ListGroupCardHeader({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.isTransaction,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isTransaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.6)),
        ),
        !isTransaction
            ? Container(
                padding: const EdgeInsets.only(top: 1.0),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Palette.greyColor.withOpacity(0.5),
                  ),
                  //color: Palette.secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                    onTap: onTap,
                    child: Icon(
                      icon,
                      size: 18,
                      color: Palette.appPrimaryColor,
                    )),
              )
            : TextButton(
                onPressed: onTap,
                child: Text(
                  'Tout afficher',
                  style: TextStyle(
                    color: Palette.blackColor.withOpacity(0.7),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ],
    );
  }
}
