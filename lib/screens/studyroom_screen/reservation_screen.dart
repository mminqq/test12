import 'package:flutter/material.dart';
import 'room_seats_screen.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('열람실 자리 예약'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomSeatsScreen(roomNumber: 1),
                ),
              );
            },
            child: Text('열람실 1'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomSeatsScreen(roomNumber: 2),
                ),
              );
            },
            child: Text('열람실 2'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomSeatsScreen(roomNumber: 3),
                ),
              );
            },
            child: Text('열람실 3'),
          ),
        ],
      ),
    );
  }
}
