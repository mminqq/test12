  import 'package:test12/model/schedule_model.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:test12/components/main_calendar.dart';
  import 'package:test12/components/schedule_card.dart';
  import 'package:test12/components/today_banner.dart';
  import 'package:test12/components/schedule_bottom_sheet.dart';
  import 'package:test12/const/colors.dart';
  import 'package:test12/screens/home_screen/home_screen.dart';
  import 'package:get_it/get_it.dart';
  import 'package:test12/database/drift_database.dart';
  import 'package:provider/provider.dart'; // ➊ Provider 불러오기
  import 'package:test12/provider/schedule_provider.dart';

  class ScheduleScreen extends StatefulWidget {
    const ScheduleScreen({Key? key}) : super(key: key);
    static String routeName = 'ScheduleScreen';
    @override
    State<ScheduleScreen> createState() => _ScheduleScreenState();
  }

  class _ScheduleScreenState extends State<ScheduleScreen> {
    DateTime selectedDate = DateTime.utc(
      // ➋ 선택된 날짜를 관리할 변수
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          // ➊ 새 일정 버튼
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            showModalBottomSheet(
              // ➋ BottomSheet 열기
              context: context,
              isDismissible: true, // ➌ 배경 탭했을 때 BottomSheet 닫기
              isScrollControlled: true,
              builder: (_) => ScheduleBottomSheet(
                selectedDate: selectedDate, // 선택된 날짜 (selectedDate) 넘겨주기
              ),
            );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          // 시스템 UI 피해서 UI 구현하기
          child: Column(
            // 달력과 리스트를 세로로 배치
            children: [
              MainCalendar(
                selectedDate: selectedDate, // 선택된 날짜 전달하기

                // 날짜가 선택됐을 때 실행할 함수
                onDaySelected: (selectedDate, focusedDate) =>
                    onDaySelected(selectedDate, focusedDate, context),
              ),
              SizedBox(height: 8.0),
              StreamBuilder<QuerySnapshot>(

                // ListView에 적용했던 같은 쿼리
                stream: FirebaseFirestore.instance
                    .collection(
                  'schedule',
                )
                    .where(
                  'date',
                  isEqualTo:
                  '${selectedDate.year}${selectedDate.month}${selectedDate.day}',
                )
                    .snapshots(),
                builder: (context, snapshot) {
                  return TodayBanner(
                    selectedDate: selectedDate,

                    // ➊ 개수 가져오기
                    count: snapshot.data?.docs.length ?? 0,
                  );
                },
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  // ➊ 파이어스토어로부터 일정 정보 받아오기
                  stream: FirebaseFirestore.instance
                      .collection(
                    'schedule',
                  )
                      .where(
                    'date',
                    isEqualTo:
                    '${selectedDate.year}${selectedDate.month}${selectedDate.day}',
                  )
                      .snapshots(),
                  builder: (context, snapshot) {
                    // Stream을 가져오는 동안 에러가 났을 때 보여줄 화면
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('일정 정보를 가져오지 못했습니다.'),
                      );
                    }

                    // 로딩 중일 때 보여줄 화면
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }

                    // ➋ ScheduleModel로 데이터 매핑하기
                    final schedules = snapshot.data!.docs
                        .map(
                          (QueryDocumentSnapshot e) => ScheduleModel.fromJson(
                          json: (e.data() as Map<String, dynamic>)),
                    )
                        .toList();

                    return ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];

                        return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (DismissDirection direction) {
                            FirebaseFirestore.instance
                                .collection('schedule')
                                .doc(schedule.id)
                                .delete();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 8.0),
                            child: ScheduleCard(
                              startTime: schedule.startTime,
                              endTime: schedule.endTime,
                              content: schedule.content,
                            ),
                          ),
                        );
                      },
                    );
                  },

                ),


              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, HomeScreen.routeName);
                },
                child: Text('홈 화면으로 이동'),
              ),
            ],
          ),
        ),
      );
    }

    void onDaySelected(
        DateTime selectedDate,
        DateTime focusedDate,
        BuildContext context,
        ) {
      setState(() {
        this.selectedDate = selectedDate;
      });
    }
  }