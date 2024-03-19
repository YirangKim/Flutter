import 'package:dio/dio.dart';
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
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//상태 클래스
class _HomePageState extends State<HomePage> {
  String quiz = '퀴즈 go';

  /**
   * initState()
   * Statefulwidget에서 위젯이 처음 생성 될 때, 실행되는 함수
   * */
  @override
  void initState() {
    super.initState();
    // 퀴즈 정보 불러와서 화면 갱신하기
    getQuiz();
  } // Number API 호출하기

  Future<String> getNumbertivia() async {
    String path = 'http://numbersapi.com/random/trivia';
    Response result = await Dio().get(path);
    String trivia = result.data;
    print(trivia);
    return trivia;
  }

  // api 가져오기 공통 사용
  void getQuiz() async {
    String trivia = await getNumbertivia();
    setState(() {
      quiz = trivia;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            /**
             * 크로스 촉이란?
             * 추축의 반대 되는 축을 크로스 축이라고 한다
             * Column의 추축은 세로 방향이고, 크로스 측은 가로 방향이다
             * */
            // 크로스축을 방향으로 가능한 많은 공감을 차지하게 함.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /**
               * Expanded 위젯
               * 레이아웃 위젯으로, 자식 위젯이 사용 가능한 추가 공간을 모두 차지하도록 확장시키는 역할
               * 주로 Row, Column과 같은 레이아웃 위젯을 사용할 때, 내부의 자식 위젯들 사이의 공간을
               * 동적으로 분배할 목적으로 사용된다*/
              Expanded(
                child: Center(
                  child: Text(
                    quiz, // body 변수 내용
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // 퀴즈 버튼
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    // 버튼 눌렀을 때 동작 print(trivia);
                    getQuiz();
                  },
                  child: Text(
                    'New Quiz',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
