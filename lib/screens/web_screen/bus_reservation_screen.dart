import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test12/screens/web_screen/bus_schedule_table.dart';
import 'package:test12/screens/web_screen/bus.dart';

class BusReservationScreen extends StatefulWidget {
  final Bus bus;

  BusReservationScreen({required this.bus});

  @override
  _BusReservationScreenState createState() => _BusReservationScreenState();
}

class _BusReservationScreenState extends State<BusReservationScreen> with ChangeNotifier {
  int selectedRow = -1;
  int selectedCol = -1;

  @override
  void initState() {
    super.initState();
    loadReservedSeats();
  }

  bool isSeatAlreadyReserved(int row, int col) {
    return widget.bus.seatStatus[row][col];
  }

  @override
  Future<void> reserveSeat(int row, int col) async {
    if (!isSeatAlreadyReserved(row, col)) {
      try {

        await FirebaseFirestore.instance.collection('seat_reservations').add({
          'row': row,
          'col': col,
          'timestamp': FieldValue.serverTimestamp(),
          'busName': widget.bus.busName, // 버스 이름 추가
        });

        widget.bus.seatStatus[row][col] = true;
        selectedRow = row;
        selectedCol = col;
        notifyListeners(); // 상태 변경을 즉시 반영
        saveReservedSeats();

        setState(() {});
      } catch (e) {
        print('좌석 예약 오류: $e');
      }
    }
  }

  @override
  Future<void> cancelReservation(int row, int col) async {
    if (isSeatAlreadyReserved(row, col)) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('seat_reservations')
            .where('row', isEqualTo: row)
            .where('col', isEqualTo: col)
            .where('busName', isEqualTo: widget.bus.busName) // 버스 이름 추가
            .get();

        querySnapshot.docs.forEach((doc) async {
          await doc.reference.delete();
        });


        widget.bus.seatStatus[row][col] = false;
        selectedRow = -1;
        selectedCol = -1;
        notifyListeners();
        saveReservedSeats();

        setState(() {});
      } catch (e) {
        print('좌석 예약 취소 오류: $e');
      }
    }
  }


  void saveReservedSeats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<bool> flattenedList = widget.bus.seatStatus.expand((list) => list).toList();
    String flattenedString = flattenedList.join(','); // List<bool>을 문자열로 변환
    prefs.setString('reservedSeats_${widget.bus.busName}', flattenedString);
  }


  void loadReservedSeats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String flattenedString = prefs.getString('reservedSeats_${widget.bus.busName}') ?? '';
    List<bool> flattenedList = flattenedString.split(',').map((e) => e == 'true').toList(); // 문자열을 List<bool>으로 변환
    for (int i = 0; i < flattenedList.length; i++) {
      widget.bus.seatStatus[i ~/ 5][i % 5] = flattenedList[i];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('${widget.bus.busName} 좌석 예약 화면'),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    GridView.builder(
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 5,
    childAspectRatio: 1.0,
    ),
    itemCount: 10,
    itemBuilder: (context, index) {
    int row = index ~/ 5;
    int col = index % 5;

    return GestureDetector(
    onTap: () {
    setState(() {
    selectedRow = row;
    selectedCol = col;
    });

    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text('좌석 예약'),
    content: isSeatAlreadyReserved(row, col)
    ? Text('이 좌석을 취소하시겠습니까?')
        : Text('이 좌석을 예약하시겠습니까?'),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text('아니오'),
    ),
    TextButton(
    onPressed: () async {
    if (isSeatAlreadyReserved(row, col)) {
    await cancelReservation(row, col);
    } else {
    await reserveSeat(row, col);
    }
    Navigator.of(context).pop();
    },
    child: Text('네'),
    ),
    ],
    ),
    );
    },
    child: Container(
    margin: EdgeInsets.all(4),
    decoration: BoxDecoration(
    color: isSeatAlreadyReserved(row, col) ? Colors.red : Colors.green,
    border: Border.all(),
    borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
    child: Text(
    '${row + 1}-${col + 1}',
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    );
    },
    ),
      SizedBox(height: 20),
    ],
    ),
    ),
    );
  }
}