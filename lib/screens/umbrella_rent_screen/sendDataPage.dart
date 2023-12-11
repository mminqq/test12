import 'package:flutter/material.dart';

class SendDataPage extends StatefulWidget {
  final String scanData;

  SendDataPage({required this.scanData});

  @override
  _SendDataPageState createState() => _SendDataPageState();
}

class _SendDataPageState extends State<SendDataPage> {
  late TextEditingController umbrellaIdController;
  late TextEditingController renterIdController;

  @override
  void initState() {
    super.initState();
    // scanData로부터 추출된 값을 초기값으로 설정
    var parsedData = parseQRData(widget.scanData);
    umbrellaIdController = TextEditingController(text: parsedData['umbrellaId'] ?? '');
    renterIdController = TextEditingController(text: parsedData['renterId'] ?? '');
  }

  @override
  void dispose() {
    umbrellaIdController.dispose();
    renterIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Data Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: umbrellaIdController,
              decoration: InputDecoration(labelText: 'Umbrella ID'),
            ),
            TextFormField(
              controller: renterIdController,
              decoration: InputDecoration(labelText: 'Renter ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 수정된 데이터를 Firebase로 전송하거나 원하는 방식으로 활용
                _sendDataToFirebase(
                  umbrellaIdController.text,
                  renterIdController.text,
                );
                // 이전 화면으로 돌아감
                Navigator.pop(context);
              },
              child: Text('전송하기'),
            ),
          ],
        ),
      ),
    );
  }

  // QR 데이터 파싱하는 함수 (이미 코드에 있던 함수를 그대로 사용)
  Map<String, dynamic> parseQRData(String qrData) {
    try {
      // 주어진 데이터를 숫자로 변환
      int value = int.tryParse(qrData) ?? 0; // 숫자가 아니면 0으로 처리하거나 다른 방식으로 처리

      // 원하는 값에 따라 키를 지정하여 Map으로 반환
      return {
        'value': value,
      };
    } catch (e) {
      return {}; // 오류 발생 시 빈 Map 반환
    }
  }


  void _sendDataToFirebase(String umbrellaId, String renterId) {
    // Firebase로 데이터 전송
    // FirebaseService().rentUmbrella(umbrellaId, renterId);
    print('Umbrella ID: $umbrellaId, Renter ID: $renterId'); // 예시로 출력
  }
}
