import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.blue, fontSize: 50, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
        ),
      ),
      home: PomodoroTimer(),
    );
  }
}

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int workTime = 1; // work time in minutes
  int restTime = 5; // rest time in minutes

  int timeLeft = 1 * 60; // initial time left in seconds
  bool isWorking = true; // flag to track if it's work or rest time
  bool isRunning = false; // flag to track if the timer is running

  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          // Switch between work and rest time
          if (isWorking) {
            timeLeft = restTime * 60;
          } else {
            timeLeft = workTime * 60;
          }
          isWorking = !isWorking;
        }
      });
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      timeLeft = workTime * 60;
      isWorking = true;
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isWorking ? 'Work Time' : 'Rest Time',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(
              '${(timeLeft ~/ 60).toString().padLeft(2, '0')}:${(timeLeft % 60).toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (!isRunning) {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    }
                  },
                  child: Text('Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (isRunning) {
                      stopTimer();
                      setState(() {
                        isRunning = false;
                      });
                    }
                  },
                  child: Text('Pause'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
