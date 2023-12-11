import 'package:test12/routes.dart';
import 'package:flutter/material.dart';
import 'package:test12/screens/splash_screen/splash_screen.dart';
import 'package:test12/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test12/firebase_options.dart';
import 'package:test12/repository/schedule_repository.dart';
import 'package:test12/provider/schedule_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:test12/database/drift_database.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:test12/screens/home_screen/home_screen.dart';

void main() async{
  kakao.KakaoSdk.init(nativeAppKey: '6a1e1c7842adca654316730a19d460c4');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  final database = LocalDatabase(); // ➊ 데이터베이스 생성

  final repository = ScheduleRepository();
  final scheduleProvider = ScheduleProvider(repository: repository);

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Brain',
        theme: CustomTheme().baseTheme,
        //initial route is splash screen
        //mean first screen
        initialRoute: HomeScreen.routeName,
        //define the routes file here in order to access the routes any where all over the app
        routes: routes,
      );
    });
  }
}
