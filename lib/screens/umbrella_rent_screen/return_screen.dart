import 'package:flutter/material.dart';
import '../umbrella_rent_screen/services/firebase_service.dart';

class ReturnScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Umbrella'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              var umbrellaInfoSnapshot = await firebaseService.getUmbrellaInfoSnapshot();
              int remainingUmbrellas = umbrellaInfoSnapshot['remainingUmbrellas'] ?? 0;
              int totalUmbrellas = umbrellaInfoSnapshot['totalUmbrellas'] ?? 0;

              if (remainingUmbrellas < totalUmbrellas) {
                // 반납할 때는 남은 우산이 전체 우산 수를 초과하지 않도록 처리
                await firebaseService.returnUmbrella('umbrella_id','user_id');
                await firebaseService.updateRemainingUmbrellaCount(remainingUmbrellas + 1);

                // 반납 완료 메시지 또는 다른 처리 추가 가능
              } else {
                // 일정 수량 이상일 때의 처리
                // 예: 사용자에게 메시지를 표시하거나 다른 동작 수행
                print('우산 보관함이 가득 찼습니다.');
              }
            } catch (e) {
              // 오류 처리
              print('오류: $e');
            }
          },
          child: Text('Return Umbrella'),
        ),
      ),
    );
  }
}
