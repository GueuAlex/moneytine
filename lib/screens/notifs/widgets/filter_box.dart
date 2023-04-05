import 'package:flutter/material.dart';

import '../../../style/palette.dart';
import 'date_filter.dart';
import 'incoming_outcoming_row.dart';

class FilterBox extends StatefulWidget {
  const FilterBox({
    super.key,
  });

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  //////////////////////////// date range ////////////////////////////////////
  ///
  DateTimeRange _selectedDates = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );
//////////////////////// dateTimeRange selector /////////////////////////
  ///
  ///
  Future<DateTimeRange?> dateTimeRange() async {
    return await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      locale: const Locale('fr', 'FR'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Palette.primarySwatch,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(
              primary: Palette.primarySwatch,
            ).copyWith(secondary: Palette.primarySwatch),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: child,
          ),
        );
      },
    );
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
              onTap: () async {
                DateTimeRange? dtr = await dateTimeRange();

                if (dtr != null) {
                  setState(() {
                    _selectedDates = dtr;
                  });
                }
                print(_selectedDates);
              },
              child: DateFilter(
                selectedDates: _selectedDates,
              ),
            ),
          ),
          const Expanded(
            child: IncomingOutcomingRow(),
          )
        ],
      ),
    );
  }
}
