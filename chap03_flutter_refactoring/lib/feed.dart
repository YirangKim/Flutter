import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  // 2 Feed 위젯의 생성자가 호출될때,
  // imageUrl을 받아올 수 있도록 required를 사용한다.
  const Feed({super.key, required this.imageUrl});
  // 1 하드코딩되어있는 이미지 url를 외부에서 전달받아 보여지게 하기 위해
  // feed.dart에 imageUrl 변수를 만들어주고,
  final String imageUrl;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // 좋아요
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.network(
        // 3 Image.network(’url’) 을 매개변수로 받아온 imageUrl로 바꿔준다
        widget.imageUrl,
        //"https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-1170x780.jpg",
        height: 400,
        width: double.infinity, //위젯 너비를 가능한 최대로 설정
        fit: BoxFit.cover,
        /**  Boxfit.cover 설명
         *  전체 프레임을 채우기 위해 사진을 확대하거나 축소함,
         *  사진이 프레임보다 작아도, 사진의 모양을 유지하면서 프레임의 모든 공간을 채우려고 자동으로 맞춰준다.
         * */
        // 이미지를 프레임 안에 꽉 차게 맞춤
      ),
      Row(
        children: [
          IconButton(
            onPressed: () {
              //하트 버튼 클릭시 onPressed() 함수가 실행
              setState(() {
                // 함수가 동작할 때, isFavorite 상태 변수가 변경
                // isFavorite 값에 따라 하트 아이콘의 색이 다르게 보이도록 코드 수정
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              CupertinoIcons.heart,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.chat_bubble,
              color: Colors.black,
            ),
          ),
          // 빈공간 추가
          Spacer(), //아이콘 사이 공백
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.bookmark,
              color: Colors.black,
            ),
          ),
        ],
      ), //Row
      // 좋아요
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "3 likes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "네온과 고양이, 최고의 조합 😎 \n#CatLife #NeonVibes",
        ),
      ),
      //날짜
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "March 6",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
    ]);
  }
}
