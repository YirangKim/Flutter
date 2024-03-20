import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class CatService extends ChangeNotifier {
  // 3 maindart SharedPreferences 변수만 만들어논 상태
  SharedPreferences prefs;

  List<String> catImages = [];
  // 좋아요 한 사진들
  List<String> favoriteCatImages = [];

  // CatService 생성자
  // 4 service에서 prefs 매개변수 받음
  CatService(this.prefs) {
    getRandomCatImages(); // Consumer<CatService> 사용
    // 7 SharedPreferences에서 좋아요 이미지 목록을 불러옵니다.
    getFavorite();
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

    // 5 SharedPreferences 적용
    // set 저장 : setStringList
    prefs.setStringList("favoriteImg", favoriteCatImages);
    notifyListeners();
  }

  // 6 SharedPreferences에서 좋아요 이미지 목록을 불러오는 메서드
  // get 사용 : getFavorite
  void getFavorite() {
    // final 사용 : SharedPreferences에서 데이터를 가져온 후에는 해당 데이터를 변경하지 않기 때문에
    // SharedPreferences에서 "favoriteImg" 키를 사용하여 데이터를 가져옵니다.
    final favoriteImg = prefs.getStringList("favoriteImg");
    // null이 아닐 때 favoriteCatImages 출력
    if (favoriteImg != null) {
      favoriteCatImages = favoriteImg;
    }
  }
}
