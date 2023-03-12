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


/* import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final DateTime startDate;

  const TimerWidget({super.key, required this.startDate});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _duration = Duration();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = DateTime.now().difference(widget.startDate);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int months = _duration.inDays ~/ 30;
    int days = _duration.inDays % 30;
    int hours = _duration.inHours % 24;
    int minutes = _duration.inMinutes % 60;
    int seconds = _duration.inSeconds % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Time elapsed:',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  months.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  'Months',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(width: 10.0),
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
} */



/* import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Duration duration = const Duration();
  Timer? timer;
  bool isCountDown = true;
  static const countDownDuration = Duration(minutes: 10);

  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() {
        duration = countDownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  void addTime() {
    final addSecond = isCountDown ? -1 : 1;
    setState(() {
      final second = duration.inSeconds + addSecond;
      if (second < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: second);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: buildTimer(),
      ),
    );
  }

  Widget buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(
          width: 8.0,
        ),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(
          width: 8.0,
        ),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 72,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          header,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
 */