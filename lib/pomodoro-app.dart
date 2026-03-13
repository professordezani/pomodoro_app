import 'dart:async';

import 'package:flutter/material.dart';

class PomodoroApp extends StatefulWidget {
  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  // atributos:
  int seconds = 60;
  var backgroundColor = Colors.green[50];
  var lightColor = Color.fromRGBO(77, 218, 110, 0.15);
  var darkColor = Color.fromRGBO(77, 218, 110, 0.62);
  var borderColor = Colors.green[900];
  var fontColor = Colors.green[900];
  var icon = Icons.coffee_outlined;
  var title = "Short Break";

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (t) => tira1Segundo(t));
  }

  void tira1Segundo(Timer _) {
    if (seconds > 0)
      setState(() => seconds -= 1);
    else
      setState(() => seconds = 25);
  }

  void add10Seconds() {
    setState(() => seconds -= 10);
  }

  @override
  Widget build(BuildContext context) {
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
                "${seconds.toString().padLeft(2, '0')}\n00",
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
                    onTap: add10Seconds,
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
                    onTap: () {},
                    child: Container(
                      width: 102,
                      height: 96,
                      decoration: BoxDecoration(
                        color: darkColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(Icons.play_arrow, size: 32),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {},
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
