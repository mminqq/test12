import 'package:flutter/material.dart';
import 'package:test12/screens/web_screen/web_page_screen.dart';
import 'package:test12/screens/web_screen/bus_reservation_screen.dart';
import 'package:test12/screens/web_screen/bus_schedule_table.dart';
import 'package:test12/screens/web_screen/bus.dart';

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
            TableCell(child: Text('14')),
            TableCell(child: Text('하교 7번')),
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
