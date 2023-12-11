// seat_reservation_screen.dart

import 'package:flutter/material.dart';

class SeatReservationScreen extends StatelessWidget {
  final int roomNumber;
  final int seatNumber;

  SeatReservationScreen({
    required this.roomNumber,
    required this.seatNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 예약 완료'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('열람실 $roomNumber 자리 $seatNumber 예약이 완료되었습니다.'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
