# mockito - 특정 파일만 모킹하는 커맨드 명령어

flutter mockito 플러그인은 test 파일에서 의존하는 모킹 클래스를 명령어를 통해 mocks 파일로 생성할 수 있다.

test 하려는 파일 이름이 a_test.dart 라면 생성된 mocks 파일은 a_test.mocks.dart 가 된다.

<br>

아래 명령어를 치면 @GenerateNiceMocks 를 작성한 모든 test 파일의 mocks 파일을 생성한다.

```bash
flutter pub run build_runner build
```

<br>

특정 파일만 mocks 파일을 생성할때는 아래의 명령어를 사용할 수 있다.

```bash
flutter pub run build_runner build 뒤에 --build-filter=경로/테스트대상파일이름.mocks.dart
```

<br>

"--build-filter=" 뒤에 붙는 경로는 프로젝트 루트 아래 폴더부터 입력하면 된다.

```
a
- lib
- test
-- c
--- c_test.dart
```

<br>

a 라는 프로젝트의 test 폴더의 c 폴더의 c_test.dart 파일에 대한 mocks 파일을 생성하려면 아래와 같이 입력하면 된다.

```bash
flutter pub run build_runner build --build-filter=test/c/c_test.mocks.dart
```



<br>

<참고>

https://pub.dev/packages/mockito#lets-create-mocks

https://github.com/dart-lang/build/issues/2928

https://github.com/dart-lang/build/issues/2815

