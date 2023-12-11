import 'package:flutter/material.dart';
import 'package:test12/screens/web_screen/bus_reservation_screen.dart';
import 'package:test12/screens/web_screen/bus.dart';

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