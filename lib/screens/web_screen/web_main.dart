import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test12/screens/web_screen/seat_reservation_screen.dart';
import 'package:test12/screens/web_screen/web_home_screen.dart'; //
import 'package:test12/screens/web_screen/seat_reservation_model.dart';
import 'package:test12/screens/web_screen/seat_reservation_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SeatReservationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebHomeScreen(),
    );
  }
}
