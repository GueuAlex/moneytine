import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../style/palette.dart';
import 'transactions_widget.dart';

class TimeLines extends StatelessWidget {
  const TimeLines({super.key, required this.isFirst});
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      afterLineStyle: const LineStyle(thickness: 2),
      beforeLineStyle: const LineStyle(thickness: 2),
      alignment: TimelineAlign.manual,
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.0,
        indicator: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.appPrimaryColor,
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
      lineXY: 0.1,
      endChild: const TransactionsWidget(),
      startChild: SizedBox(
        width: 20,
        child: Column(
          children: const [
            Text(
              '16',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              'Oct',
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
