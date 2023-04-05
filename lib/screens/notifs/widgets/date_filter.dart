import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/palette.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({
    super.key,
    required this.selectedDates,
  });

  final DateTimeRange selectedDates;

  int calculateMonthDifference(DateTimeRange dateRange) {
    Duration duration = dateRange.end.difference(dateRange.start);
    int totalDays = duration.inDays;
    int totalMonths = (totalDays / 30).ceil();
    return totalMonths;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
            ),
            decoration: BoxDecoration(
                color: Palette.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('yyyy').format(selectedDates.start),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Palette.blackColor.withOpacity(0.3),
                  ),
                ),
                FittedBox(
                  child: Text(
                    '${DateFormat.MMMMd('fr').format(selectedDates.start)} - ${DateFormat.MMMMd('fr').format(selectedDates.end)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 8.0,
            top: 8.0,
            bottom: 8.0,
          ),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          width: 100,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Palette.greyColor.withOpacity(0.5),
            ),
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    '${selectedDates.duration.inDays} Jours',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Palette.primaryColor,
                    ),
                  ),
                ),
                const FittedBox(
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
