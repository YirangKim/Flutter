import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LikePage.dart';
import 'package:chap07_flutter_randomcat/cat_service.dart';

void main() async {
  // 1 main() 함수 에서 async 를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();

  // Shared_preferences 인스턴스 생성
  // 1 getInstance읽어와서 prefs 저장 -> 리스트
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      //MultiProvider 상태값이 바뀌는걸 관리
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                CatService(prefs) // 2 생성자 호출할 때 파라미터로 SharedPreferences 전달
            ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3 null을 반환하는 경우 false를 기본값으로 지정
    //bool favoriteImg = prefs.getBool("favoriteImg") ?? false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// /// ToDo클래스
// class ToDo {
//   String imgUrl; //이미지 url
//   ToDo(this.imgUrl); // 생성자
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "랜덤 고양이",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.indigo,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  // + 버튼 클릭시 LikiPage생성 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LikePage()),
                  );
                },
              )
            ],
          ),
          // GridView count 생성자로, 그리드 내 아이템 수를
          // 기반으로 레이아웃을 구성할 수 있다.
          body: GridView.count(
            //크로스 축으로 아이템이 2개씩 배치되도록 설정
            crossAxisCount: 2,
            // 그리드의 주측(세로) 사이의 아이템 공간 설정
            mainAxisSpacing: 8,
            // 그리드의 크로스측(가로) 사이의 아이템 공간 설정
            crossAxisSpacing: 8,
            // 그리드 전체에 대한 패딩 설정
            padding: EdgeInsets.all(8),
            // 그리드에 표시될 위젯 리스트, 10개 위젯 생성
            children: List.generate(catService.catImages.length, (index) {
              String catImages = catService.catImages[index];
              return GestureDetector(
                //GestureDetector 이미지 선택할수 있게
                child: Stack(
                  // Stack 사이즈 제각각
                  children: [
                    /**
                     * Positioned
                     * Stack 내에서 자식 위젯의 위치를 정밀하게 제어할 때 사용.
                     * top, right, bottom, left, 네가지 속성으로 위치 조정
                     * Positioned.fill 4가지 속성이 모두 0츠로 설정되며,
                     * Stack 모든면을 채우도록 설정된다
                     * */
                    Positioned.fill(
                      child: Image.network(
                        catImages,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite,
                        color: catService.favoriteCatImages.contains(catImages)
                            ? Colors.pink
                            // 투명한색
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  //사진 클릭시 작동
                  print(index);
                  // toggleFavoriteImage 메서드는 사용자가 이미지를 좋아요/취소하도록 하는 기능
                  // 이미지의 인덱스를 찾아 좋아요한 사진 목록 업데이트 : 좋아요/취소
                  catService.toggleFavoriteImage(catImages);
                },
              );
            }),
          ),
        );
      },
    );
  }
}
