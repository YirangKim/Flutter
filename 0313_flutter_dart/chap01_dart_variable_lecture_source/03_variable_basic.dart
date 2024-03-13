void main() {
  /**
   * 정수형 데이터를 다루는 자료형 list
   */
  int num1 = 5;
  int num2 = 10;

  print(num1 + num2);
  print(num1 - num2);
  print(num1 * num2);
  print(num1 / num2);

  /**
   * 실수형 데이터를 다루는 자료형 double`
   */

  double num3 = 5.5;
  double num4 = 1.1;

  print(num3 + num4);
  print(num3 - num4);
  print(num3 * num4);
  print(num3 / num4);

  /**
   * double과 int를 둘다 포함하고 있는 num
   */

  num num5 =1;
  num num6 = 1.1;

  print(num5 + num6);
  if(num is num){
    print('num5는 [num]타입입니다');
  }
  if(num5 is int){
    print('num5는 [int]타입입니다');
  }

  /**
   * 참 거짓 boolean 변수를 저장할 수 있는 자료형 bool
   */

  bool wrong = false;
  print(wrong); // false

  wrong = !wrong;
  print(wrong); // ture

}