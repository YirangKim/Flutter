void main(){

  sayhello();
  sayhello2();

  print('---- 매개변수와 반환타입 -----');
  print(add(1,2));

  print('---- Option1 매개변수 -----');
  print(add2(1,2,3)); 
  print(add2(1,2)); //c를 안썼을 때
}



void sayhello(){
  print('hello world');
}

// Arrow Function 함수를 짧게 표현 가능
void sayhello2() => print("hello world");

String add(int a, int b){
  int sum = a + b;

  return "Sum : ${sum}";
}

String add2(int a, int b, [int c = 1]){
  int sum = a + b + c;
  return "Sum2 : ${sum}";
}