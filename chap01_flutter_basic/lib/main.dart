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
        title: 'App 타이틀',
        //App의
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('AppBar'),
            backgroundColor: Colors.blue,
          ),
          body: Text('Body 입니다'),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'school',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.access_alarm),
            onPressed: () => {
              print('hello'),
            },
          ),
        ));
  }
}
