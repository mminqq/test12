import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'umbrella_screen.dart'; // 이동할 화면 import
import 'package:geolocator/geolocator.dart';


class UmbrellaRentHomeScreen extends StatefulWidget {
  const UmbrellaRentHomeScreen({Key? key}) : super(key: key);
  static String routeName = 'UmbrellaRentScreen';

  @override
  _UmbrellaRentHomeScreenState createState() => _UmbrellaRentHomeScreenState();
}

class _UmbrellaRentHomeScreenState extends State<UmbrellaRentHomeScreen> {
  static final LatLng umbrellaLatlng = LatLng(36.83363, 127.1792);

  static final Marker marker = Marker(
    markerId: MarkerId('umbrella'),
    position: umbrellaLatlng,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),

  );

  static final Circle circle = Circle(
    circleId: CircleId('choolCheckCircle'),
    center: umbrellaLatlng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: 100,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == '위치 권한이 허가 되었습니다.') {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: umbrellaLatlng,
                      zoom: 16,
                    ),
                    myLocationEnabled: true,
                    markers: Set.from([marker]),
                    circles: Set.from([circle]),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.beach_access,
                        color: Colors.purpleAccent,
                        size: 80.0,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () async {
                          final curPosition =
                          await Geolocator.getCurrentPosition();

                          final distance = Geolocator.distanceBetween(
                            curPosition.latitude,
                            curPosition.longitude,
                            umbrellaLatlng.latitude,
                            umbrellaLatlng.longitude,
                          );
                          bool canCheck = distance < 100;

                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('대여&반납 하기'),
                                content: Text(
                                  canCheck
                                      ? '우산 관리 페이지로 이동하시겠습니까?'
                                      : '이용할수 없는 위치입니다.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('취소'),
                                  ),
                                  if (canCheck)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => umbrellaScreen(), // UmbrellaScreen으로 이동
                                          ),
                                        );
                                      },
                                      child: Text('이동하기'),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('우산 대여 및 반납 하기!'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Text(
              snapshot.data.toString(),
            ),
          );
        },
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text(
        '우산 대여 or 반납하기',
        style: TextStyle(
          color: Colors.purpleAccent,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<String> checkPermission() async {
    final isLocationEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화해주세요.';
    }

    LocationPermission checkedPermission =
    await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 설정에서 허가해주세요.';
    }

    return '위치 권한이 허가 되었습니다.';
  }
}
