import 'package:flutter/foundation.dart';

class SeatReservationProvider with ChangeNotifier {
  Set<String> _reservedSeats = {};

  Set<String> get reservedSeats => _reservedSeats;

  void reserveSeat(String seatNumber) {
    _reservedSeats.add(seatNumber);
    notifyListeners();
  }

  void cancelReservation(String seatNumber) {
    _reservedSeats.remove(seatNumber);
    notifyListeners();
  }
}
