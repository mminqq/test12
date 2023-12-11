// seat_widget.dart

import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final bool isReserved;
  final Function() onTap;

  SeatWidget({
    required this.seatNumber,
    required this.isReserved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isReserved ? null : onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isReserved ? Colors.red : Colors.green,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
