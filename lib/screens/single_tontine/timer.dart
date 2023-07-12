import 'dart:async';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime endDate;

  CountdownWidget({required this.endDate});

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  Duration _duration = Duration();

  @override
  void initState() {
    super.initState();
    _duration = widget.endDate.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = widget.endDate.difference(DateTime.now());
      });
      if (_duration.inSeconds <= 0) {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int days = _duration.inDays;
    int hours = _duration.inHours % 24;
    int minutes = _duration.inMinutes % 60;
    int seconds = _duration.inSeconds % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Time remaining:',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  days.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  'Days',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                Text(
                  hours.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  'Hours',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                Text(
                  minutes.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  'Minutes',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                Text(
                  seconds.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  'Seconds',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
