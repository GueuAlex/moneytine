import 'package:flutter/material.dart';

import '../../../models/notification_models.dart';
import '../../../models/transation_by_date.dart';
import '../../../style/palette.dart';
import 'date_filter.dart';
import 'incoming_outcoming_row.dart';

class FilterBox extends StatefulWidget {
  const FilterBox({
    super.key,
    required this.interval,
    required this.data,
  });

  final DateTimeRange interval;
  final List<DataByDate<NotificationModel>> data;

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  ////////////
  ///
  double totalTransactions({
    required List<DataByDate<NotificationModel>> data,
    required String type,
  }) {
    double total = 0;
    for (DataByDate<NotificationModel> element in data) {
      for (NotificationModel notif in element.data) {
        if (notif.type.toLowerCase() == type.toLowerCase()) {
          total += notif.amount;
          //print(total);
        }
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // déplace l'ombre vers le bas
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // déplace l'ombre vers le haut
          )
        ],
        color: Palette.whiteColor,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: InkWell(
              child: DateFilter(
                selectedDates: widget.interval,
              ),
            ),
          ),
          Expanded(
            child: IncomingOutcomingRow(
              versement:
                  totalTransactions(data: widget.data, type: "versement"),
              retrait: totalTransactions(data: widget.data, type: "retrait"),
            ),
          )
        ],
      ),
    );
  }
}
