import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getUmbrellaInfoStream() {
    return _firestore.collection('meta').doc('umbrella_info').snapshots();
    // 'umbrella_info' 문서의 스냅샷을 반환하는 스트림
  }

  Future<void> setInitialUmbrellaCount() async {
    try {
      await _firestore.collection('meta').doc('umbrella_info').set({
        'totalUmbrellas': 50,
        'remainingUmbrellas': 50,
      });
      // 초기 우산 수량을 Firebase에 설정
    } catch (e) {
      // 오류 처리
    }
  }

  Future<void> rentUmbrella(String umbrellaId, String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot umbrellaInfoSnapshot = await transaction
            .get(_firestore.collection('meta').doc('umbrella_info'));

        int remainingUmbrellas =
            umbrellaInfoSnapshot['remainingUmbrellas'] ?? 0;
        int totalUmbrellas = umbrellaInfoSnapshot['totalUmbrellas'] ?? 0;

        if (remainingUmbrellas > 0 && totalUmbrellas > 0) {
          // 우산이 남아 있을 때만 대여 처리
          transaction.update(
            _firestore.collection('umbrellas').doc(umbrellaId),
            {
              'status': 'rented',
              'renterId': userId,
              'rentTimestamp': DateTime.now(),
            },
          );

          transaction.update(
            _firestore.collection('meta').doc('umbrella_info'),
            {
              'remainingUmbrellas': remainingUmbrellas - 1,
            },
          );
        }
      });
    } catch (e) {
      // 오류 처리
    }
  }

  Future<void> returnUmbrella(String umbrellaId, String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot umbrellaInfoSnapshot = await transaction
            .get(_firestore.collection('meta').doc('umbrella_info'));

        int remainingUmbrellas =
            umbrellaInfoSnapshot['remainingUmbrellas'] ?? 0;
        int totalUmbrellas = umbrellaInfoSnapshot['totalUmbrellas'] ?? 0;

        if (remainingUmbrellas < totalUmbrellas) {
          // 반납할 때는 남은 우산이 전체 우산 수를 초과하지 않도록 처리
          transaction.update(
            _firestore.collection('umbrellas').doc(umbrellaId),
            {
              'status': 'available',
              'renterId': null,
              'rentTimestamp': null,
            },
          );

          transaction.update(
            _firestore.collection('meta').doc('umbrella_info'),
            {
              'remainingUmbrellas': remainingUmbrellas + 1,
            },
          );
        }
      });
    } catch (e) {
      // 오류 처리
    }
  }

  Future<void> updateTotalUmbrellaCount(int totalUmbrellas) async {
    try {
      await _firestore.collection('meta').doc('umbrella_info').update({
        'totalUmbrellas': totalUmbrellas,
      });
      // 전체 우산 수량을 Firebase에 업데이트
    } catch (e) {
      // 오류 처리
    }
  }

  Future<void> updateRemainingUmbrellaCount(int remainingUmbrellas) async {
    try {
      await _firestore.collection('meta').doc('umbrella_info').update({
        'remainingUmbrellas': remainingUmbrellas,
      });
      // 남은 우산 수량을 Firebase에 업데이트
    } catch (e) {
      // 오류 처리
    }
  }

  Future<DocumentSnapshot> getUmbrellaInfoSnapshot() async {
    try {
      // 'umbrella_info' 문서의 스냅샷을 가져옴
      DocumentSnapshot snapshot =
      await _firestore.collection('meta').doc('umbrella_info').get();
      return snapshot;
    } catch (e) {
      // 오류 처리
      throw ('오류: $e');
    }
  }


  Future<bool> checkReturnConditions(String umbrellaId, String userId) async {
    try {
      // 우산 정보 가져오기
      DocumentSnapshot umbrellaSnapshot = await _firestore.collection(
          'umbrellas').doc(umbrellaId).get();

      if (umbrellaSnapshot.exists) {
        String? rentedBy = umbrellaSnapshot['renterId'];
        String? rentTimestampStr = umbrellaSnapshot['rentTimestamp'];

        if (rentedBy == userId && rentTimestampStr != null) {
          DateTime rentTimestamp = DateTime.parse(rentTimestampStr);
          DateTime currentDateTime = DateTime.now();

          Duration rentalDuration = currentDateTime.difference(rentTimestamp);
          // 예시: 24시간 이상이 지나면 반납 가능
          if (rentalDuration.inHours >= 24) {
            return true; // 조건 충족
          }
        }
      }
      return false; // 조건 불충족
    } catch (e) {
      print('오류: $e');
      return false; // 오류 발생 시 또한 조건 불충족
    }
  }



}
