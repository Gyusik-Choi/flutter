#  안드로이드 Kotlin 에서 Java 로 변경

flutter 로 프로젝트를 생성하면 default 로는 kotlin 파일이 생성되는데 이를 java 로 변경하고 싶을 수 있다.

```
flutter create -a java .
```

<br>

해당 명령어를 통해 java 기반의 MainActivity 파일을 생성할 수 있다.

그러나 아래와 같은 에러가 발생할 수 있다. 개인적인 경우로 프로젝트명을 둘 중 어떤 것을 해야할지 모호하다고 나왔었다.

```
The --org command line argument must be specified to recreate project.
```

<br>

그래서 구글링을 해보니 flutter create -a java . 의 . 대신 프로젝트명을 적으라고 되어있었으나 잘 되지 않았다. 그래서 직접 폴더 및 java 파일을 생성해줬다.

그리고 android -> app -> build.gradle 에서 android 의 kotlinOptions, sourceSets 를 지우고, dependencies 의 implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version" 을 지워주었다.

<br>

이렇게 하고서 에뮬레이터를 실행하니 정상적으로 실행은 되었는데, java 폴더가 회색으로 남아있고 MainActivity.java 파일이 kotlin 파일과 달리 뭔가 임시 파일과 같은 아이콘으로 남아있는게 찜찜했다. 이 또한 구글링을 해보니 프로젝트의 android 부분만 따로 android studio 로 열어주니 gradle sync 가 되면서 java 폴더가 회색에서 흰색으로 변했다. 다만 java 파일의 아이콘은 android -> build.gradle 에 설정한 build.gradle 버전이 낮아서 나타나는 문제로 보인다. 이 버전이 개인적으로는 4.1.3 인데 7 이상인 프로젝트에서는 다른 아이콘 모양으로 나왔다.

<br>

<참고>

https://stackoverflow.com/questions/56620802/how-can-create-a-flutter-project-with-org-in-vscode

https://stackoverflow.com/questions/64468323/flutter-cannot-resolve-symbol-embedding-and-cannot-resolve-symbol-flutteracti

https://muhly.tistory.com/77