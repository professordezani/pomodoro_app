import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

class PomodoroApp extends StatefulWidget {
  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

enum Status { shortBreak, workHard }

class _PomodoroAppState extends State<PomodoroApp> {
  // atributos:
  int seconds = 30;
  var backgroundColor = Colors.green[50];
  var lightColor = Color.fromRGBO(77, 218, 110, 0.15);
  var darkColor = Color.fromRGBO(77, 218, 110, 0.62);
  var borderColor = Colors.green[900];
  var fontColor = Colors.green[900];
  var icon = Icons.coffee_outlined;
  var title = "Short Break";
  var status = Status.shortBreak;
  var paused = true;
  var timerIcon = Icons.play_arrow;

  Timer? _timer;
  int increaseCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  void _start() {
    if (paused) {
      _timer = Timer.periodic(Duration(seconds: 1), _decrease1Second);
      paused = false;
      timerIcon = Icons.pause;
    }
  }

  void _cancel() {
    if (!paused) {
      _timer?.cancel();
      paused = true;
      timerIcon = Icons.play_arrow;
      setState(() {});
    }
  }

  void _decrease1Second(Timer _) {
    if (seconds > 1) {
      setState(() => seconds -= 1);
    } else {
      _changeStatus();
    }

    if (seconds == 5) {
      setState(() => backgroundColor = Colors.orange[50]);
    }
  }

  void _playSound() {
    var player = AudioPlayer();
    player.play(AssetSource('sounds/bell.mp3'));
  }

  void _changeStatus() {
    _playSound();
    if (status == Status.shortBreak) {
      status = Status.workHard;
      seconds = 60;
      backgroundColor = Colors.red[50];
      lightColor = Color.fromRGBO(255, 76, 76, 0.15);
      darkColor = Color.fromRGBO(255, 76, 76, 0.62);
      borderColor = Colors.red[900];
      fontColor = Colors.red[900];
      icon = Icons.run_circle_outlined;
      title = "Work Hard";
    } else {
      status = Status.shortBreak;
      seconds = 30;
      backgroundColor = Colors.green[50];
      lightColor = Color.fromRGBO(77, 218, 110, 0.15);
      darkColor = Color.fromRGBO(77, 218, 110, 0.62);
      borderColor = Colors.green[900];
      fontColor = Colors.green[900];
      icon = Icons.coffee_outlined;
      title = "Short Break";
    }
    increaseCount = 0;
    setState(() {});
  }

  void _increase10Seconds() {
    if (increaseCount < 6) {
      increaseCount++;
      setState(() => seconds += 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    var txtMinutes = (seconds ~/ 60).toString().padLeft(2, '0');
    var txtSeconds = (seconds % 60).toString().padLeft(2, '0');
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  color: lightColor,
                  border: Border.all(color: borderColor!),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(icon), Text(title)],
                ),
              ),
              Text(
                "$txtMinutes\n$txtSeconds",
                style: TextStyle(
                  fontSize: 256,
                  color: fontColor,
                  fontWeight: FontWeight.w300,
                  height: 0.85,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: _increase10Seconds,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(Icons.forward_10_outlined, size: 32),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: paused ? _start : _cancel,
                    child: Container(
                      width: 102,
                      height: 96,
                      decoration: BoxDecoration(
                        color: darkColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(timerIcon, size: 32),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: _changeStatus,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(Icons.fast_forward, size: 32),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
