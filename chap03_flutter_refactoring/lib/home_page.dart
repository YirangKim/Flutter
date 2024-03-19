import 'package:chap03_flutter_refactoring/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // imageUrl은 변하지 않으므로, final로 선언
    final List<String> images = [
      "https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-1170x780.jpg",
      "https://gratisography.com/wp-content/uploads/2023/10/gratisography-cool-cat-1170x780.jpg",
      "https://gratisography.com/wp-content/uploads/2023/10/gratisography-witch-cat-1170x780.jpg",
      "https://gratisography.com/wp-content/uploads/2023/09/gratisography-duck-doctor-free-stock-photo-1170x780.jpg",
      "https://gratisography.com/wp-content/uploads/2023/06/gratisography-boxing-boxer-free-stock-photo-1170x780.jpg",
      "https://gratisography.com/wp-content/uploads/2023/06/gratisography-dj-gorilla-free-stock-photo-1170x780.jpg",
      "https://gratisography.com/wp-content/uploads/2023/06/gratisography-panda-ice-cream-free-stock-photo-1170x780.jpg",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // AppBar의 음영을 조절하여 붕 떠있는 것 같은 효과를 준다.
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.camera,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.paperplane,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        title: Image.asset(
          'assets/images/og_logo.png',
          scale: 32,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          // feed.dart로 imageUrl을 넘겨주기 위해,
          // home_page에서 body에 Feed()를 return 할때
          // ListView.builder를 사용해서 images 리스트에 있는 값을 하나씩 넘겨준다
          return Feed(
            imageUrl: image,
          );
        },
      ),
    );
  }
}
