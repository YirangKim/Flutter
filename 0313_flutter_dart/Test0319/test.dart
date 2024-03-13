void main(){
  print("--- 문제 1번---");
  print("다트는 재미있다");
  
  print("--- 문제 2번----");
  Human human = new Human('비비', 25, 170.5);
  print(human.doHello());
  
  print("--- 문제 3번 ----");
  var number;
  
  number = 10;//초기화
  print(number);

  number = "다이나믹듀오";
  print(number);

  
  // print("--- 문제 3-1 ----");
  // dynamic number1 = 10;
  // print(number1);
  
  // number1 = "배정현T";
  // print(number1);
  
}


class Human{
  //인스턴스 변수
  String name;
  int age;
  double height;

  // 생성자
  Human(this.name, this.age, this.height);

  getName(){
    this.name;
  }

  String doHello(){
    return "내 이름은${name}이고, 나이는 ${age}살, 키는 ${height}입니다.";
  }
 
}