void main(){

  Teacher teacher = Teacher('bear', 99);
  print("teacher 팀: ${teacher.team}");
  print("teacher 이름: ${teacher.name}");
  print("teacher 나이: ${teacher.age}");

  teacher.nagging();
}

class Teacher extends Ohgiraffers{
  String? name;
  int? age;

  Teacher(String name, int age){
    this.name = name;
    this.age = age;
  }
}

class Ohgiraffers{
  String team = 'ohgiraffers';

  void nagging(){
    print('공부하세요!!!!');
  }

}