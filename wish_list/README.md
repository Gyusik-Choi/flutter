# wish_list1

### 개요

getx 상태관리 툴을 바탕으로 무한 스크롤과 좋아요 기능을 구현한 개인 프로젝트 입니다.

<br>

### 구현 기능

무한 스크롤

좋아요 + 좋아요 목록 관리

<br>

### 구조

```
lib
 ┣ bindings
 ┃ ┗ binding.dart
 ┣ controller: 데이터 상태관리 및 데이터 관련 로직 요청
 ┃ ┗ data_controller.dart
 ┣ data
 ┃ ┣ model: 외부 API 데이터 등의 직렬화, 역직렬화
 ┃ ┃ ┗ model.dart
 ┃ ┣ providers: controller에서 필요한 로직 수행
 ┃ ┃ ┗ api.dart
 ┃ ┗ repository: controller와 provider를 연결(controller와 provider 분리)
 ┃ ┃ ┗ posts_repository.dart
 ┣ routes
 ┣ ui: 화면 구성
 ┃ ┣ home.dart
 ┃ ┗ wish.dart
 ┗ main.dart
```

[getx_pattern](https://kauemurakami.github.io/getx_pattern/) 을 활용하여 프로젝트 구조를 잡았습니다.

bindings 의 의존성 관리에 대한 이해가 부족하여 제대로 활용하지 못한 점이 아쉬움으로 남았습니다.

<br>

참고

https://kauemurakami.github.io/getx_pattern/

https://github.com/jonataslaw/getx/issues/314

https://here4you.tistory.com/276
