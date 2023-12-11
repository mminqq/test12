import 'package:flutter/material.dart';
import '../umbrella_rent_screen/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RentScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Umbrella'),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: firebaseService.getUmbrellaInfoStream(), // 우산 정보 스트림을 가져옴
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              int remaining = snapshot.data!['remainingUmbrellas'] ?? 0;

              return ElevatedButton(
                onPressed: () async {
                  if (remaining > 0) {
                    await firebaseService.rentUmbrella('umbrella_id', 'user_id');
                    // 실제 대여 로직 수행
                  } else {
                    // 대여할 우산이 없는 경우에 대한 처리
                    // 예: 사용자에게 메시지를 표시하거나 다른 동작 수행
                  }
                },
                child: Text('Rent Umbrella'),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
