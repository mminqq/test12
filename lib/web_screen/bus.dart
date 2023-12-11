class Bus {
  final String busName;
  final String busId;
  final List<List<bool>> seatStatus;

  Bus({required this.busName, required this.busId})
      : seatStatus = List.generate(2, (row) => List.filled(5, false));
}
