import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences 인스턴스를 어디서든 접근 가능 하도록 전역 변수로 선언
// late : 나중에 꼭 값을 할당해준다는 의미.
// 1 전역변수
late SharedPreferences prefs;

void main() async {
  // main() 함수 에서 async 를 쓰려면 필요
  // 2-1세트
  WidgetsFlutterBinding.ensureInitialized();

  // Shared_preferences 인스턴스 생성
  // 2 getInstance읽어와서 prefs 저장 -> 리스트
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SharedPreferences 에서 온보딩 완료 여부 조회
    // isOnboarded 해당하는 값에서 null을 반환하는 경우 false를 기본값으로 지정
    // 3 변수 선언,  isOnboarded 값
    // 파일 isOnboarded 있고, 변수 isOnboarded 있는 것 구분
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "KCCGanpan",
      ),
      title: 'Who Am I',
      // isOnboarded 값에 따라 Homepage로 열지 TestScreen으로 열지 결정됨.
      home: isOnboarded ? HomePage() : TestScreen(), //4 처음에는, 다시 실행할때는 true
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: '현재의 나',
      titleTextStyle: TextStyle(
          color: Colors.purple,
          fontSize: 35,
          fontFamily: "KCCGanpan",
          fontWeight: FontWeight.w200),
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
  //{'isOnboarded': true}
  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        // 마지막 페이지가 나오거나 skip을 해서 Homepage로 가기전에 isOnboarded를 true로 바꿔준다
        // 5 버튼을 클릭했을 때, 파일에 강제 저장
        // boolean true, false
        // set 저장
        prefs.setBool('isOnboarded', true);
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
        actions: [
          IconButton(
              //휴지통버튼
              onPressed: () {
                prefs.clear();
              },
              icon: Icon(Icons.delete))
        ],
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
