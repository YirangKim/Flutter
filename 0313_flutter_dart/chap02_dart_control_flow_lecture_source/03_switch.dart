void main(){
  /**
   * 조건문 [switch문] : 특정 조건별로 코드를 실행시키고 싶을 때 사용한다
   */

  int num = 15;

  switch (num % 3){
    case 0:
    print('나머지가 없습니다.');

    case 1:
    print('나머지 : ${num %3}');

    default:
    print('일치하는 조건이 없으면 실행됩니다.');
    break;
  }
}