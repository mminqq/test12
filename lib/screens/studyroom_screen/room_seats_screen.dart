import 'package:flutter/material.dart';
import 'seat_widget.dart';
import 'seat_reservation_screen.dart';

class RoomSeatsScreen extends StatefulWidget {
  final int roomNumber;

  RoomSeatsScreen({required this.roomNumber});

  @override
  _RoomSeatsScreenState createState() => _RoomSeatsScreenState();
}

class _RoomSeatsScreenState extends State<RoomSeatsScreen> {
  List<bool> seatReservationStatus = List.generate(30, (index) => false);
  int selectedSeatNumber = 0;

  void updateSelectedSeat(int seatNumber) {
    setState(() {
      selectedSeatNumber = seatNumber;
    });
  }

  void returnSeat(int seatNumber) {
    setState(() {
      seatReservationStatus[seatNumber - 1] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalSeats = 30;
    int remainingSeats = totalSeats - seatReservationStatus.where((reserved) => reserved).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('열람실 ${widget.roomNumber} 자리 안내'),
        actions: [
          IconButton(
            onPressed: () {
              if (selectedSeatNumber > 0) {
                returnSeat(selectedSeatNumber);
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text('남은 좌석: $remainingSeats / 총 좌석: $totalSeats'),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (context, index) {
                int seatNumber = index + 1;
                return SeatWidget(
                  seatNumber: seatNumber,
                  isReserved: seatReservationStatus[index],
                  onTap: () {
                    setState(() {
                      seatReservationStatus[index] = true;
                    });

                    updateSelectedSeat(seatNumber);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatReservationScreen(
                          roomNumber: widget.roomNumber,
                          seatNumber: seatNumber,
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: totalSeats,
            ),
          ),
        ],
      ),
    );
  }
}
