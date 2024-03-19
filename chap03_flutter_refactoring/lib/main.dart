import 'package:chap03_flutter_refactoring/feed.dart';
import 'package:chap03_flutter_refactoring/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //MaterialApp 디자인 패턴 구조 - scaffold 레이아웃ㅎ
      debugShowCheckedModeBanner: false,
      home: HomePage(), //맨처음 보여지는 화면
    );
  }
}

// class MyCustomListView extends StatelessWidget {
//   // 사용자 정의 데이터 리스트
//   final List<String> entries = <String>['A', 'B', 'C', 'D', 'E' 'F'];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         Container(
//           height: 100,
//           color: Colors.amber[100],
//           child: Center(child: Text('A')),
//         ),
//         Container(
//           height: 100,
//           color: Colors.amber[200],
//           child: Center(child: Text('B')),
//         ),
//         Container(
//           height: 100,
//           color: Colors.amber[300],
//           child: Center(child: Text('C')),
//         ),
//         Container(
//           height: 100,
//           color: Colors.amber[400],
//           child: Center(child: Text('D')),
//         ),
//         Container(
//           height: 100,
//           color: Colors.amber[500],
//           child: Center(child: Text('E')),
//         ),
//         Container(
//           height: 100,
//           color: Colors.amber[600],
//           child: Center(child: Text('F')),
//         ),
//       ],
//     );
//   }
// }
