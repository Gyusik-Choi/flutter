# todo_1

## bloc pattern + stream + sqflite



### 에러

#### 네트워크 에러

```
Exception in thread "main" java.net.UnknownHostException: services.gradle.org
```

네트워크와 관련된 에러였다. 스타벅스의 WIFI를 사용하고 있었는데, 스마트폰 핫스팟으로 바꾸니 해결됐다.

<br>

### 개발 중 이슈

#### update 안 되는 현상 발생

todo 아이템의 네모 상자 혹은 체크 표시를 누르면 상태가 변해야 하는데, 그러지 못하는 현상이 발생했다.

한참을 디버깅 하고나서 원인을 찾았다. db에서 가져온 객체를 map으로 변환할때 컬럼에 오타가 있었다. is_done을 isDone으로 해놔서 계속해서 값이 바뀌지 않았다.

<br>

<참고>

https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692

https://cyj893.github.io/flutter/Flutter2_3/

