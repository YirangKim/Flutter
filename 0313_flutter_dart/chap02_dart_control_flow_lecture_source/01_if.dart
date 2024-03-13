
// ignore_for_file: dead_code

void main(){
/**
 * 조건문 [if문] : 조건에 따라 실행하고 싶은 코드를 나눌 때 사용한다.
 */

  bool boolean = true;
  if(boolean) {
    print("boolean : $boolean");
  } else{
    print("boolean : ${boolean}");
  }

  /**
   * 조건문은 else if 형태로 계속 조건을 추가할 수 있다
   * 앞에서 부터 하나씩 비교를 하면서, 조건 하나라도 true로 실행되면 조건문을 실행되지 않느다
   */

  print("--- elseif ---");
  bool boolean1 = false;
  bool boolean2 = true;

  if(boolean1){
    // boolean이 true 이면 실행
    print("boolean1 : $boolean1");
  } else if (boolean2){
    // boolean이 false이고, boolean2가 true이면 실행
    print("boolean2 : $boolean2");
  } else {
    print("boolean1과 2가 false입니다");
  }
}