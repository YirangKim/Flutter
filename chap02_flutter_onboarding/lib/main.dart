import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // backgroundColor: Color.fromARGB(255, 36, 34, 34),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: '현재의 나',
      subTitle: '12년동안 브랜딩디자이너였다가 서른넘어서 처음 개발 배워 개발자를 꿈꾸고 있다.',
      imageUrl: 'assets/images/onboarding3.png',
    ),
    Introduction(
      title: '수료후의 나',
      subTitle: '개발자 ‘인턴’이라도 시작해보겠다는 마음가짐(일은 직접 부딪혀가며 배우는게 최고의 습득 방법이므로)',
      imageUrl: 'assets/images/onboarding4.png',
    ),
    Introduction(
      title: '10년 후의 나',
      subTitle: '2034 자랑스러운 여성벤처인 표창 김이랑',
      imageUrl: 'assets/images/onboarding5.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ), //MaterialPageRoute
        );
      },
      // foregroundColor: Colors.red,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to Home Page!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
