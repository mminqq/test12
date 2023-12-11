import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../umbrella_rent_screen/services/firebase_service.dart';
import '/screens/umbrella_rent_screen/QRCodeScanner.dart'; //페이지 이동


class umbrellaScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  Widget umbrellasInfo(int remaining, int total) {
    return Column(
      children: [
        Text(
          '남은 우산 수: $remaining / $total',
          style: TextStyle(fontSize: 40),
        ),
        // 필요한 경우 추가 데이터 표시 위젯을 여기에 추가할 수 있습니다.
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('우산 대여 및 반납 서비스'),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: firebaseService.getUmbrellaInfoStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              int totalUmbrellas = snapshot.data!['totalUmbrellas'] ?? 0;
              int remainingUmbrellas = snapshot.data!['remainingUmbrellas'] ?? 0;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/umbrella.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '남은 우산 수: $remainingUmbrellas / $totalUmbrellas',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 50),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton(
            onPressed: () {
            if (remainingUmbrellas > 0) {
            _showRentConfirmationDialog(context);
            }
            },
            child: Text('우산 대여하기'),
            ),
            SizedBox(width: 100),
            ElevatedButton(
            onPressed: () {
            if (remainingUmbrellas < totalUmbrellas) {
            _showReturnConfirmationDialog(context);
            }
            },
            child: Text('우산 반납하기'),
                        ),

                    ],
                  ),

                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  void _showRentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('우산을 대여하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _navigateToQRScannerScreen(context); // QR 코드 스캔 화면으로 이동
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }

  void _showReturnConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('우산을 반납하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _navigateToQRScannerScreen(context); // QR 코드 스캔 화면으로 이동
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToQRScannerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRCodeScannerScreen()),
    );
  }

  void _returnUmbrella(BuildContext context, String userId) {
    Navigator.of(context).pop(); // 다이얼로그 닫기

    // 반납 로직 추가
    firebaseService.returnUmbrella('umbrellaId', userId).then((_) {
      // 반납에 성공한 경우의 추가 로직
      print('반납 성공!');
    }).catchError((error) {
      // 반납에 실패한 경우의 추가 로직 또는 에러 처리
      print('반납 실패: $error');
    });
  }

}
