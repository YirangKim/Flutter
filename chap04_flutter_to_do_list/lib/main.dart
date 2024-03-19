import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // ListVew.builder코드
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
} // MyApp

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
} // HomePage

class _HomePageState extends State<HomePage> {
  //List<String> toDoList = ['잔디심기'];
  // 클래스 타입
  List<ToDo> toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: toDoList.isEmpty
          ? Center(
              // 리스트가 비어있음
              child: Text("To Do List 작성해주세요"),
            )
          : ListView.builder(
              //리스트가 있으면
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                ToDo toDo = toDoList[index]; //인스턴스
                return ListTile(
                  title: Text(
                    toDo.job, //job 갑자기 어디서??
                    style: TextStyle(
                      fontSize: 20,
                      color: toDo.isDone ? Colors.grey : Colors.black,
                      decoration: toDo.isDone
                          ? TextDecoration.lineThrough // 삭제시 line 적용
                          : TextDecoration.none,
                    ),
                  ),
                  // ToDoList 삭제 기능
                  trailing: IconButton(
                    icon: Icon(
                      CupertinoIcons.delete,
                    ),
                    onPressed: () {
                      // 삭제 버튼을 눌렀을 때 Dialog를 띄우기
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('삭제하시겠습니까?'),
                              //alther 창에 취소 및 삭제 버튼 추가
                              actions: [
                                // 취소버튼
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '취소',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                // 삭제버튼
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      //삭제 버튼을 클릭할 경우 ToDoList에서 해당 값 삭제
                                      toDoList.removeAt(index);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '삭제',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  ),
                  onTap: () {
                    //아이템 클릭시
                    // ToDoList의 아이템 클릭시 isDone 속성 반전
                    // isDone 속성에 따라 화면에 다르게 출력
                    setState(() {
                      toDo.isDone = !toDo.isDone;
                    });
                    print('${toDo.job} : 아이템이 클릭됨');
                  },
                );
              }),
      // FlaotingActionButton 추가 및 버튼을 눌렀을 때, CreatePage로 연결
      // 추가하기 버튼(floatingActionButton) 클릭 시, 홈 화면으로 이동하고
      // ToDoList에 항목을 추가하기 위해, 값을 HomePage로 반환
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // HomePage에서 async await를 이용하여 toDo를 전달 받는다.
          // +버튼 클릭시 버킷 생성 페이지로 이동
          String? job = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
          //전달받은 값이 null 이 아닌경우에 ToDoList에 추가
          if (job != null) {
            setState(() {
              ToDo newToDo = ToDo(job, false);
              toDoList.add(newToDo);
              //print("toDo 리스트는 : " + job);
            });
          }
        },
      ),
    );
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

// CreatePage 구현하기 및 _Createpage와  textController 연결
// Scaffold를 적용하여 AppBar 및 body를 작성한다.
class _CreatePageState extends State<CreatePage> {
  // TestField의 값을 가져올 때 사용
  // _CreatePageState에 TextEditingController 생성
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDoList 작성'),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //텍스트 입력창
            TextField(
              //화면이 나오면 바로 입력창에 커서가 올수 있게함
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                errorText: error, //에러 메세지 출력
                hintText: "할 일을 입력하세요",
              ),
            ),
            // sizedBox: Row, Column 등에서 widget사이에 빈 공간을 넣기 위해 사용
            SizedBox(
              height: 20,
            ),
            // sizedBox : child widget의 size를 강제하기 위해 사용
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  //추가하기 버튼 클릭하면 작동
                  String toDo = textController.text;
                  // todo의 입력폼 값이 비여있으면
                  //  “내용을 입력해주세요”라는 에러메시지 표시하기.
                  if (toDo.isEmpty) {
                    setState(() {
                      //내용이 없는경우 에러 메세지
                      error = "내용을 입력해주세요";
                    });
                  } else {
                    //내용이 있는 경우 에러메세지 숨김
                    setState(() {
                      error = null;
                    });
                    // toDo 변수를 반환하며 화면 바뀜
                    Navigator.pop(context, toDo);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ToDo 클래스
// ToDoList를 String 만 반환하는 것이아닌
// 완료 여부를 나태는 상태를 추가하기 위해 ToDo 클래스를 만들어준다.
// 기존 List 의 타입을 String에서 ToDo 로변경해준다.
class ToDo {
  String job; //
  bool isDone; //

  ToDo(this.job, this.isDone); //생성자
}
