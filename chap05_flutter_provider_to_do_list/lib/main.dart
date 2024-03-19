import 'package:chap05_flutter_provider_to_do_list/to_do_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /**
     * Provider를 사용해, ToDoService를 위젯트리의 최상단에 배치하고,
     * 어디서든 접근 가능하게 한다.
     * ToDoService는 ToDoList 값이 변경 될때마다,
     * 변경사항을 HomePage에 알려주어야하므로,
     * ChangeNotifierProvider로 Provider에 등록해준다.
     * */
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToDoService()),
      ],
      child: const MyApp(),
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

/// ToDo 클래스
class ToDo {
  String job; // 할 일
  bool isDone; // 완료 여부

  ToDo(this.job, this.isDone); // 생성자
}

// 홈페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  /** HomePage 위젯을 Consumer로 감싸기
   * Scafold 위젯을 alt + enter 를 통해 builder로 wrap 해준다.
   * builder 를 Consumer<ToDoService> 로 변경하고
   * context옆에 toDoService와 child를 추가해준다.
   * */
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoService>(
      builder: (context, toDoService, child) {
        // toDoService로 부터 toDoList 가져오기
        // toDoService로 부터 toDoList 가져오기
        List<ToDo> toDoList = toDoService.toDoList;

        return Scaffold(
          appBar: AppBar(
            title: Text("ToDo 리스트"),
          ),
          body: toDoList.isEmpty
              ? Center(
                  child: Text("ToDo 리스트를 작성해 주세요."),
                )
              : ListView.builder(
                  itemCount: toDoList.length,
                  itemBuilder: (context, index) {
                    ToDo toDo = toDoList[index];
                    return ListTile(
                      title: Text(
                        toDo.job,
                        style: TextStyle(
                          fontSize: 20,
                          color: toDo.isDone ? Colors.grey : Colors.black,
                          decoration: toDo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          CupertinoIcons.delete,
                        ),
                        onPressed: () {
                          // 삭제 버튼 클릭시
                          toDoService.deleteToDo(index);
                        },
                      ),
                      onTap: () {
                        //아이템 클릭시
                        toDo.isDone = !toDo.isDone;
                        toDoService.updateToDo(toDo, index);
                      },
                    );
                  }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // + 버튼 클릭시 ToDo 생성 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePage()),
              );
            },
          ),
        );
      },
    );
  }
}

/// ToDo 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "To Do List를 작성해주세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 20),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      // 내용이 없는 경우 에러 메세지
                      error = "내용을 입력해주세요.";
                    });
                  } else {
                    setState(() {
                      // 내용이 있는 경우 에러 메세지 숨김
                      error = null;
                    });
                    /**
                     * 추가하기 버튼을 클릭하면, createToDo 함수를 호출하고,
                     * job을 add해준다.
                     */
                    ToDoService todoService = context.read<ToDoService>();
                    todoService.createToDo(job);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
