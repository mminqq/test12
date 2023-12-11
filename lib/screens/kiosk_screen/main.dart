import 'package:flutter/material.dart';
import 'package:test12/screens/kiosk_screen/home_screen.dart'; //이동 페이지

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: '상명대 학식 주문하기'), //이동하는 페이지
    );
  }
}
