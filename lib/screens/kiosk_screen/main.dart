import 'package:flutter/material.dart';
import 'package:kiosk/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: '상명대 학식 주문하기'),
    );
  }
}
