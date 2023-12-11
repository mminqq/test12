import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../umbrella_rent_screen/services/firebase_service.dart';
import '/screens/umbrella_rent_screen/rentING_screen.dart'; //페이지 이동


class QRCodeScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code 대여 Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      print(scanData);
      await FirebaseService().rentUmbrella('umbrellaId', 'userId');

      bool isRentSuccessful = true;

      if (isRentSuccessful) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("대여 성공했습니다"),
              actions: [
                ElevatedButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop(); // 현재 다이얼로그를 닫음
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => rentIngScreen(), // RentingScreen으로 이동
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
      else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("대여 실패했습니다"),
              actions: [
                ElevatedButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }


    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

