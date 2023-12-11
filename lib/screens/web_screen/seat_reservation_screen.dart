import 'package:flutter/material.dart';
import 'seat_reservation_model.dart';

class SeatReservationScreen extends StatelessWidget {
  final SeatReservationModel seatReservationModel = SeatReservationModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 예약'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('좌석 예약 화면'),

            ElevatedButton(
              onPressed: () {
                // 다이얼로그 표시
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('좌석 예약'),
                      content: Text('좌석을 예약하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // "네"를 선택했을 때 모델을 통해 좌석 예약 정보 업데이트
                            seatReservationModel.reserveSeat(0, 0);

                            // 다이얼로그 닫기
                            Navigator.of(context).pop();
                          },
                          child: Text('네'),
                        ),
                        TextButton(
                          onPressed: () {
                            // "아니오"를 선택하면 다이얼로그만 닫기
                            Navigator.of(context).pop();
                          },
                          child: Text('아니오'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: seatReservationModel.isSeatAlreadyReserved(0, 0)
                    ? Colors.red
                    : Colors.green,
              ),
              child: Text('좌석 1-1'),
            ),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('좌석 예약'),
                      content: Text('좌석을 예약하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            seatReservationModel.reserveSeat(0, 1);
                            Navigator.of(context).pop();
                          },
                          child: Text('네'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('아니오'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: seatReservationModel.isSeatAlreadyReserved(0, 1)
                    ? Colors.red
                    : Colors.green,
              ),
              child: Text('좌석 1-2'),
            ),
            Text(
              '예약 상태: ${seatReservationModel.isSeatAlreadyReserved(0, 0) ? '예약됨' : '예약 안됨'}',
            ),
          ],
        ),
      ),
    );
  }
}
