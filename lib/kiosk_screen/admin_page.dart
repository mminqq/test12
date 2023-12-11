import 'package:flutter/material.dart';

class admin_page extends StatelessWidget {
  const admin_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('메뉴 추가'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('메뉴 삭제'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('메뉴 수정'),
          ),
        ],
      ),
    );
  }
}