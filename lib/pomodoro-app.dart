import 'package:flutter/material.dart';

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: Colors.green[50],
        child: SafeArea(
          child: Container(
            width: 125,
            decoration: BoxDecoration(
              color: Color.fromRGBO(77, 218, 110, 0.15),
              border: Border.all(color: Colors.green[900]!),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              // spacing: 4,
              children: [Icon(Icons.coffee_outlined), Text("Short Break")],
            ),
          ),
        ),
      ),
    );
  }
}
