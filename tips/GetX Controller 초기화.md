# GetX Controller 초기화

A Controller 를 두개의 StatelessWidget 클래스인 B, C에서 사용한다고 가정하자.

B에서 A Controller 가 생성되고, 만약 B에서 C로 이동하여 C에서 A Controller 를 찾으면(find) A controller의 내용이 그대로 유지된다.

그런데 만약에 C에서 B로 되돌아갔을때는 A Controller의 내용을 초기화하고 싶다면 어떻게 해야할까?

<br>

처음에는 모든 내용을 새로 기존 값으로 대입하는 것을 생각했으나 값이 추가될 때마다 초기화하는 코드도 변경되야하고 비효율적이라고 느껴졌다.

해결 방법은 생각보다 간단했다. 해당 컨트롤러를 지우고 이전 페이지로 이동하는 방법이다.

```dart
// 라우팅 설정에서 B클래스의 name 속성을 '/B'로 해놓았다고 가정
Get.delete<AController>();
Get.offAndToNamed('/B');
```

<br>

[소스코드 주석](https://github.com/jonataslaw/getx/blob/master/lib/get_navigation/src/extension_navigation.dart)에 따르면 offNamed와 offAndToNamed가 거의 같지만 페이지 스택에서 빼고 넣는 순서가 다르다.

```
It is very similar to offNamed() but use a different approach

The offNamed() pop a page, and goes to the next. The offAndToNamed() goes to the next page, and removes the previous one. The route transition animation is different.
```

<br>

<참고>

https://stackoverflow.com/questions/66292416/how-do-i-reset-my-controller-when-i-come-back-or-finish

https://github.com/jonataslaw/getx/blob/master/lib/get_navigation/src/extension_navigation.dart 