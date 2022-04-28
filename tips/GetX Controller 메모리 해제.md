## GetX controller 메모리 해제

### 앞으로 이동

Get.to, Get.toNamed 로 이동할때 이동하기 전의 페이지와 이동하는 페이지가 서로 다른 controller를 사용해도 기존의 controller는 메모리에서 해제되지 않는다.

offNamed, offAllNamed 등의 off가 포함된 메소드로 이동할때 기존의 controller가 메모리에서 해제된다. offAllNamed의 경우 기존 페이지 스택에 쌓인 모든 controller가 메모리에서 해제된다.

<br>

### 뒤로 이동

Get.back()으로 이동할때 이동하기 전의 페이지와 이동하는 페이지가 서로 다른 controller를 사용하면 기존의 controller가 메모리에서 해제된다.

<br>

### 스택

앞으로 이동하면서 Get.to, Get.toNamed는 스택에 새로운 페이지를 쌓기 때문에 그대로 controller가 유지되면서 새로운 controller도 생기는데, Get.off~(), Get.back() 등은 스택에서 제거를 해버리기 때문에 기존의 controller가 지워진다.

<br>

### 기타

(안드로이드 에뮬레이터의 화면 하단 버튼이 아닌 우측 세로 사이드바에서 뒤로가기를 눌렀을 경우에도 이동하기 전의 페이지와 이동하는 페이지가 서로 다른 controller를 사용할 경우에도 기존의 controller가 메모리에서 해제된다.)

(화면 하단 버튼은 현재 에뮬레이터 버그로 눌러지지 않아서 테스트하지 못했다. 에뮬레이터를 삭제했다가 다시 생성하면 눌러지긴 하지만 이도 얼마 못가서 다시 안눌리게 된다. 에뮬레이터를 삭제하면 기존의 내부 DB도 모두 없어져서 아직 시도하지 못했다.)