import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TodoService extends ChangeNotifier {
  final todoCollection = FirebaseFirestore.instance.collection('todo');

  //읽기
  // QuerySnapshot : 파이어베이스에서 쿼리를 실행한 결과로 반환되는 객체
  // 쿼리결과로 반환된 여러 doc의 스냅샷을 가지고 있다.
  Future<QuerySnapshot> read(String uid) async {
    //내 toDoList 가져오기
    throw UnimplementedError(); //임시로 return값 미구현 에러안나오게
  }

  //쓰기
  void create(String job, String uid) async {
    //todo 만들기
  }

  //변경
  void update(String docId, bool isDone) async {
    //todo inDone update
  }

  //삭제
  void delete(String docId) async {
    //toDo 삭제
  }
}