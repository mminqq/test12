import 'package:flutter/material.dart';
import 'package:test12/screens/home_screen/home_screen.dart'; //이동 페이지

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> order = [];
  final List<Map<String, dynamic>> foodList = [
    {'imgUrl': 'assets/images/alchon.jpg', 'name': '알밥 5500원', 'price': 5500},
    {'imgUrl': 'assets/images/bulgogi.jpg', 'name': '제육덮밥 7000원', 'price': 7000},
    {'imgUrl': 'assets/images/chicken.jpg', 'name': '치킨덮밥 7000원', 'price': 7000},
    {'imgUrl': 'assets/images/dong.jpg', 'name': '우동 4000원', 'price': 4000},
    {'imgUrl': 'assets/images/pork_cutlets.jpg', 'name': '돈까스  8000원', 'price': 8000},
    {'imgUrl': 'assets/images/jja.jpg', 'name': '짜장면 6500원', 'price': 6500},
    {'imgUrl': 'assets/images/six.jpg', 'name': '육계장 7500원', 'price': 7500}
  ];

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () => Navigator.of(context).push(
            _createRoute(admin_page()),
          ),
          child: Text(
            '상명대 학식 주문하기',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '주문 리스트',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: order.isEmpty
                  ? Center(child: Text('주문한 메뉴가 없습니다'))
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: order.length,
                itemBuilder: ((context, index) {
                  return Chip(
                    label: Text(
                        '${order[index]['name']}'),
                    onDeleted: () => setState(() {
                      order.removeAt(index);
                    }),
                  );
                }),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '음식',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              flex: 10,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(foodList.length, (index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      order.add({
                        'name': foodList[index]['name'],
                        'price': foodList[index]['price']
                      });
                    }),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image(
                              image: AssetImage(
                                foodList[index]['imgUrl'],
                              ),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            foodList[index]['name'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '[담기]',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: order.isNotEmpty ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton.extended(
          onPressed: () {
            int totalPrice = 0;
            for (var item in order) {
              if (item['price'] != null) {
                totalPrice += item['price'] as int;
              }
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('총 주문 금액'),
                  content: Text('총 금액: $totalPrice 원'),
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
          },
          label: Text(
            '결제하기',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          backgroundColor: Colors.grey[200],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
