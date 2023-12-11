import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test12/screens/web_screen/bus_schedule_table.dart';
import 'package:test12/screens/web_screen/afternoon_bus_schedule_table.dart';
import 'package:test12/screens/web_screen/bus_reservation_screen.dart';
import 'package:test12/screens/web_screen/bus.dart';

class WebPageScreen extends StatefulWidget {
final String title;

WebPageScreen({required this.title});

@override
_WebPageScreenState createState() => _WebPageScreenState();
}

class _WebPageScreenState extends State<WebPageScreen> {
late StreamController<DateTime> _timeController;
late Stream<DateTime> _timeStream;
late String currentTime;

void goToBusReservationScreen() {
Navigator.push(
context,
MaterialPageRoute(
  builder: (context) => BusReservationScreen(bus: Bus(busName: 'Bus Name', busId: 'Bus ID')),


),
);
}

@override
void initState() {
super.initState();

_timeController = StreamController<DateTime>();
_timeStream = _timeController.stream;

// 타이머 설정
Timer.periodic(Duration(seconds: 1), (timer) {
DateTime now = DateTime.now();
_timeController.add(now);

// 매 초마다 현재 시간과 버스 출발 시간 비교
if (now.minute == 0) {
checkBusDepartureTime();
}
});
}

// 현재 시간과 버스 출발 시간 비교 및 알림 표시
void checkBusDepartureTime() {
// 예시로 16시를 기준으로 설정
DateTime busDepartureTime = DateTime(
DateTime.now().year,
DateTime.now().month,
DateTime.now().day,
16,
35,
);

// 현재 시간
DateTime currentTime = DateTime.now();


if (currentTime.isBefore(busDepartureTime.subtract(Duration(minutes: 10)))) {
// 10분 전에 알림 표시
showDialog(
context: context,
builder: (context) => AlertDialog(
title: Text('주의'),
content: Text('버스가 10분 후에 출발합니다!'),
actions: [
TextButton(
onPressed: () {
Navigator.of(context).pop();
},
child: Text('확인'),
),
],
),
);
}

}

@override
void dispose() {
_timeController.close();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.title),
centerTitle: true,
backgroundColor: Colors.blue, // 연두색
),
body: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'버스안내(셔틀버스)',
style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
),
SizedBox(height: 20),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.asset(
'asset/img/shuttle1.jpeg',
width: 170,
height: 170,
fit: BoxFit.cover,
),
SizedBox(width: 20),
Image.asset(
'asset/img/shuttle2.jpeg',
width: 170,
height: 170,
fit: BoxFit.cover,
),
],
),
SizedBox(height: 20),
Text(
'내용.',
style: TextStyle(fontSize: 18),
),
SizedBox(height: 20),
Padding(
padding: const EdgeInsets.only(left: 8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'가.오전 운행: 등교',
style:
TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),
BusScheduleTable(),
],
),
),
SizedBox(height: 20),
Padding(
padding: const EdgeInsets.only(left: 8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'나.오후 운행: 하교',
style:
TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),
AfternoonBusScheduleTable(),
],
),
),
SizedBox(height: 20),
//

],
),
),
),
);
}
}
class TimeBuilder extends StatelessWidget {
final Stream<DateTime> stream;
final Widget Function(BuildContext, AsyncSnapshot<DateTime>) builder;

TimeBuilder({required this.stream, required this.builder});

@override
Widget build(BuildContext context) {
return StreamBuilder<DateTime>(
stream: stream,
builder: builder,
);
}
}


class BusScheduleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(child: Text('회차')),
            TableCell(child: Text('차량명칭')),
            TableCell(child: Text('두정역 출발')),
            TableCell(child: Text('학교 도착')),
            TableCell(child: Container()),
          ],
        ),
        TableRow(
          children: [
            TableCell(child: Text('1')),
            TableCell(child: Text('등교1번')),
            TableCell(child: Text('07 : 50')),
            TableCell(child: Text('08 : 20')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교1번', busId: 'Bus 1')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(child: Text('2')),
            TableCell(child: Text('등교2번')),
            TableCell(child: Text('08 : 15')),
            TableCell(child: Text('08 : 45')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교2번', busId: 'Bus 2')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('3')),
            TableCell(child: Text('등교3번')),
            TableCell(child: Text('08 : 20')),
            TableCell(child: Text('08 : 50')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교3번', busId: 'Bus 3')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('4')),
            TableCell(child: Text('등교4번')),
            TableCell(child: Text('08 : 25')),
            TableCell(child: Text('08 : 55')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교4번', busId: 'Bus 4')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('5')),
            TableCell(child: Text('등교5번')),
            TableCell(child: Text('08 : 30')),
            TableCell(child: Text('09 : 00')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교5번', busId: 'Bus 5')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('6')),
            TableCell(child: Text('등교6번')),
            TableCell(child: Text('09 : 10')),
            TableCell(child: Text('09 : 25')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교6번', busId: 'Bus 6')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('7')),
            TableCell(child: Text('등교7번')),
            TableCell(child: Text('09 : 40')),
            TableCell(child: Text('10 : 10')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '등교7번', busId: 'Bus 7')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

      ],
    );
  }
}

class AfternoonBusScheduleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(child: Text('회차')),
            TableCell(child: Text('차량')),
            TableCell(child: Text('학교 출발(정문 앞)')),
            TableCell(child: Text('터미널 애슐리 앞')),
            TableCell(child: Text('천안역 50m전방 빠리안경 앞')),
            TableCell(child: Container()),
          ],
        ),// 빈 셀
        TableRow(
          children: [
            TableCell(child: Text('8')),
            TableCell(child: Text('하교1번')),
            TableCell(child: Text('14 : 30')),
            TableCell(child: Text('14 : 40')),
            TableCell(child: Text('14 : 50')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교1번', busId: 'Bus8')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('9')),
            TableCell(child: Text('하교2번')),
            TableCell(child: Text('15 : 00')),
            TableCell(child: Text('15 : 10')),
            TableCell(child: Text('15 : 20')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교2번', busId: 'Bus9')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('10')),
            TableCell(child: Text('하교3번')),
            TableCell(child: Text('15 : 30')),
            TableCell(child: Text('15 : 40')),
            TableCell(child: Text('15 : 50')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교3번', busId: 'Bus 10')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('11')),
            TableCell(child: Text('하교4번')),
            TableCell(child: Text('16 : 00')),
            TableCell(child: Text('16 : 10')),
            TableCell(child: Text('16 : 20')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교4번', busId: 'Bus 11')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('12')),
            TableCell(child: Text('하교5번')),
            TableCell(child: Text('16 : 30')),
            TableCell(child: Text('16 : 40')),
            TableCell(child: Text('16 : 50')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교5번', busId: 'Bus 12')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('13')),
            TableCell(child: Text('하교6번')),
            TableCell(child: Text('17 : 00')),
            TableCell(child: Text('17 : 10')),
            TableCell(child: Text('17 : 20')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교6번', busId: 'Bus 13')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TableRow(
          children: [
            TableCell(child: Text('하교7번')),
            TableCell(child: Text('신우')),
            TableCell(child: Text('17 : 30')),
            TableCell(child: Text('17 : 40')),
            TableCell(child: Text('17 : 50')),
            TableCell(
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusReservationScreen(bus: Bus(busName: '하교7번', busId: 'Bus 14')),

                    ),
                  );
                },
              ),
            ),
          ],
        ),

      ],
    );
  }
}