
import 'package:test12/screens/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:test12/screens/studyroom_screen/studyroom_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'schedule_screen/schedule_screen.dart';

import 'screens/umbrella_rent_screen/umbrella_rent_home_screen.dart';



Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),

  HomeScreen.routeName: (context) => HomeScreen(),
  ScheduleScreen.routeName: (context) => ScheduleScreen(),
  StudyroomScreen.routeName: (context) => StudyroomScreen(),

  UmbrellaRentHomeScreen.routeName: (context) => UmbrellaRentHomeScreen(),
};