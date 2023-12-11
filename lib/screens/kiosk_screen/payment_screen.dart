import 'package:flutter/material.dart';
import 'package:test12/screens/kiosk_screen/toss_payments_widget.dart'; // 수정된 부분

class PaymentScreen extends StatelessWidget {
  final List<String> order;

  const PaymentScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('결제 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('주문 내역: ${order.join(', ')}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TossPaymentsWidget(order: order), // 수정된 부분
                  ),
                );
              },
              child: const Text('결제하기'),
            ),
          ],
        ),
      ),
    );
  }
}
