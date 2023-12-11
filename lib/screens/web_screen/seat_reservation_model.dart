import 'package:flutter/foundation.dart';

class SeatReservationModel extends ChangeNotifier {
  List<List<bool>> seatStatus = List.generate(2, (row) => List.filled(5, false));
  int selectedRow = -1;
  int selectedCol = -1;

  bool isSeatAlreadyReserved(int row, int col) {
    return seatStatus[row][col];
  }

  void reserveSeat(int row, int col) {
    if (!isSeatAlreadyReserved(row, col)) {
      seatStatus[row][col] = true;
      selectedRow = row;
      selectedCol = col;
      notifyListeners();
    }
  }
}
