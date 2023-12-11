import 'dart:async';
import 'package:flutter/material.dart';
import 'reservation_screen.dart';

class StudyroomScreen extends StatefulWidget {
  const StudyroomScreen({Key? key}) : super(key: key);
  static String routeName = 'StudyroomScreen';
  @override
  _StudyroomScreenState createState() => _StudyroomScreenState();
}

class _StudyroomScreenState extends State<StudyroomScreen> {
  Timer? _timer;
  int _remainingTimeInSeconds = 3 * 60 * 60;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), _updateRemainingTime);
  }

  void _updateRemainingTime(Timer timer) {
    if (_remainingTimeInSeconds > 0) {
      setState(() {
        _remainingTimeInSeconds -= 1;
      });

      // 10분 남았을 때 알림 표시
      if (_remainingTimeInSeconds == 10 * 60) {
        _showNotification('10분 남았습니다!');
      }
    } else {
      _timer?.cancel();
    }
  }

  void _extendTime() {
    // 10분 남았을 때만 연장 가능하도록 체크
    if (_remainingTimeInSeconds <= 10 * 60) {
      _showNotification('10분 이상 남아야 연장이 가능합니다.');
      return;
    }

    // 연장하기 버튼을 누를 때 타이머 초기화 및 재시작
    setState(() {
      _remainingTimeInSeconds = 3 * 60 * 60; // 3시간을 초 단위로 계산
    });
    _startTimer();
  }

  void _showNotification(String message) {
    // 알림을 표시하는 기능을 추가할 수 있습니다.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  String getFormattedTime() {
    int hours = _remainingTimeInSeconds ~/ 3600;
    int minutes = (_remainingTimeInSeconds % 3600) ~/ 60;
    int seconds = _remainingTimeInSeconds % 60;

    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('열람실 자리 예약'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _startTimer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReservationScreen()),
                );
              },
              child: Text('자리 예약하기'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _extendTime,
              child: Text('연장하기'),
            ),
            SizedBox(height: 20),
            Text(
              '남은 시간: ${getFormattedTime()}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
