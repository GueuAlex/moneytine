import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../style/palette.dart';

class RapelNotification extends StatelessWidget {
  const RapelNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 50,
      margin: const EdgeInsets.only(top: 5.0),
      // padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      //color: Colors.red,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            width: 100,
            // height: 120,
            child: Container(
              padding: const EdgeInsets.all(13.0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/exclamation.svg',
                color: Palette.appPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //height: 120,
              //color: Colors.amber,
              padding: const EdgeInsets.only(right: 8.0, left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Votre contribution ',
                      style: const TextStyle(
                        //fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'mensuelle ',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              //color: Colors.red,
                              ),
                        ),
                        const TextSpan(
                          text: 'pour',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              //color: Colors.red,
                              ),
                        ),
                        const TextSpan(
                          text: ' tontineName ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Colors.red,
                          ),
                        ),
                        const TextSpan(
                          text: 'est dû le',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              //color: Colors.red,
                              ),
                        ),
                        TextSpan(
                          text: DateFormat(' MMM,dd,yyyy ')
                              .format(DateTime.now()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Colors.red,
                          ),
                        ),
                        const TextSpan(
                          text: '\n50000 FCFA',
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Palette.appPrimaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      DateFormat('à HH:mm').format(DateTime.now()),
                      style: const TextStyle(
                        color: Palette.greyColor,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
