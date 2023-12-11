import 'package:test12/const/colors.dart';
import 'package:test12/constants.dart';
import 'package:test12/schedule_screen/schedule_screen.dart';
import 'package:test12/screens/assignment_screen/assignment_screen.dart';
import 'package:test12/screens/datesheet_screen/datesheet_screen.dart';
import 'package:test12/screens/umbrella_rent_screen/umbrella_rent_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test12/screens/studyroom_screen/studyroom_screen.dart';
import 'package:sizer/sizer.dart';
import 'widgets/student_data.dart';
import 'package:test12/kakao_login_screen/kakao_login.dart';
import 'package:test12/kakao_login_screen/main_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            return ElevatedButton(
              onPressed: () async {
                await viewModel.login();
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor ,
                onPrimary: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                // 카카오 로그인 아이콘 이미지
                Image.asset(
                'assets/images/kakao.jpg', // 이미지 리소스의 경로
                width: 250, // 이미지의 가로 크기
                height: 250, // 이미지의 세로 크기
              ),

              // 카카오 로그인 텍스트
              const SizedBox(width: 8), // 이미지와 텍스트 사이의 간격 조절
              const Text('카카오 로그인'),
              ],
            ),

            );
          }

          // Check if Kakao login is successful

          // If not logged in with Kakao, show the existing content
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? '',
              ),
              Text(
                '${viewModel.isLogined}',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.logout();
                  setState(() {});
                },
                child: const Text('로그아웃하기'),
              ),
              // Bottom part of the screen
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: kOtherColor,
                    borderRadius: kTopBorderRadius,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeCard(
                              onPress: () {
                                Navigator.pushNamed(
                                    context, ScheduleScreen.routeName);
                              },
                              icon: 'assets/icons/timetable.svg',
                              title: '캘린더',
                            ),
                            HomeCard(
                              onPress: () {

                              },
                              icon: 'assets/icons/schedule.svg',
                              title: '시간표예정',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeCard(
                              onPress: () {
                                Navigator.pushNamed(
                                    context, UmbrellaRentHomeScreen.routeName);
                              },
                              icon: 'assets/icons/rain.svg',
                              title: '우산대여서비스예정',
                            ),
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/food.svg',
                              title: '학생식당 예정',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeCard(
                              onPress: () {
                                Navigator.pushNamed(
                                    context, StudyroomScreen.routeName);
                              },
                              icon: 'assets/icons/parking.svg',
                              title: '주차장 예정',
                            ),
                            HomeCard(
                              onPress: () {

                              },
                              icon: 'assets/icons/datesheet.svg',
                              title: 'DateSheet',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/ask.svg',
                              title: 'Ask',
                            ),
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/gallery.svg',
                              title: 'Gallery',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/resume.svg',
                              title: 'Leave\nApplication',
                            ),
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/lock.svg',
                              title: 'Change\nPassword',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/event.svg',
                              title: 'Events',
                            ),
                            HomeCard(
                              onPress: () {},
                              icon: 'assets/icons/logout.svg',
                              title: 'Logout',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
