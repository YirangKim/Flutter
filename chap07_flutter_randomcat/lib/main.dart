import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatService()),
      ],
      child: MyApp(),
    ),
  );
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

class CatService extends ChangeNotifier {
  List<String> catImages = [];
  // 좋아요 한 사진들
  List<String> favoriteCatImages = [];

  // CatService 생성자
  CatService() {
    getRandomCatImages();
  }

  // 고양이 이미지 10개 가져오는 메서드
  void getRandomCatImages() async {
    String path =
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg";
    var result = await Dio().get(path);
    print(result.data);
    for (int i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      // print(map);
      print("map url 조회 : " + map['url']);
      //catImage에 이미지 url추가
      catImages.add(map['url']);
    }
    notifyListeners();
  }

  // 좋아요 기능
  void toggleFavoriteImage(String catImage) {
    if (favoriteCatImages.contains(catImage)) {
      favoriteCatImages.remove(catImage);
    } else {
      favoriteCatImages.add(catImage);
    }
    notifyListeners();
  }
}

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
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ))
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
                          color:
                              catService.favoriteCatImages.contains(catImages)
                                  ? Colors.pink
                                  // 투명한색
                                  : Colors.transparent,
                        ))
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
