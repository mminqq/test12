import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../umbrella_rent_screen/services/firebase_service.dart';
import '/screens/home_screen/home_screen.dart'; //페이지 이동
import 'package:cloud_firestore/cloud_firestore.dart';



class QRCodeReturnScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeReturnScannerState();
}

class _QRCodeReturnScannerState extends State<QRCodeReturnScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code 반납 Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue, // Change color for clarity
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
      // 추출된 데이터
      print(scanData);
      await FirebaseService().rentUmbrella('umbrellaId', 'userId');

      bool isReturnSuccessful = true;

      if (isReturnSuccessful) {

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("반납 성공했습니다"),
              actions: [
                ElevatedButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("반납 실패했습니다"),
              actions: [
                ElevatedButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Add any additional logic after failed return
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
