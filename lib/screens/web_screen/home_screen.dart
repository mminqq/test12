import 'package:flutter/material.dart';
import 'package:test12/screens/web_screen/web_page_screen.dart';
import 'package:test12/screens/web_screen/school_bus_webview.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상명대학교 버스 시간 안내'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'asset/img/smu.jpg',
            width: 300,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebPageScreen(
                        title: '셔틀버스 안내',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  onPrimary: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.directions_bus, size: 40),
                    SizedBox(height: 10),
                    Text(
                      '셔틀버스 안내',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchoolBusWebView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lime,
                  onPrimary: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.directions_bus, size: 40),
                    SizedBox(height: 10),
                    Text(
                      '통학버스 안내',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
