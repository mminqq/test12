import 'package:flutter/material.dart';
import '/screens/umbrella_rent_screen/QRCodeReturnScanner.dart';//페이지 이동


class rentIngScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Renting Umbrella'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 우산을 대여 중입니다.',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20), // 텍스트와 버튼 사이 간격 조절
            ElevatedButton(
              onPressed: () {
                _navigateToQRReturnScannerScreen(context); // 반납을 위한 QR 코드 스캔 화면으로 이동
              },
              child: Text('반납하기'),
            ),
            SizedBox(height: 20), // 추가된 버튼과 텍스트 사이의 간격 조절
            ElevatedButton(
              onPressed: () {
                _navigateToHomeScreen(context); // 홈 화면으로 이동
              },
              child: Text('홈 화면으로 이동'),
            ),



          ],
        ),
      ),
    );
  }

  void _navigateToQRReturnScannerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRCodeReturnScanner()), // 반납을 위한 QR 코드 스캔 화면으로 이동
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)); // 홈 화면으로 이동
  }

}
