import 'package:flutter/material.dart';
import 'package:emotion_log/log_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expansion View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogScreen(),
    );
  }
}