# todo_2

## bloc pattern + stream + sqflite

### 개요

todo_1 에 이어서 [이분](https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692)의 코드를 토대로 flutter 의 bloc pattern 과 stream 에 익숙해지려 했다.

### 구조

ui <-> bloc <-> repository <-> dao <-> database + model

<br>

### 마무리

todo_1 에서 아쉬움으로 남았던 UI 부분을 이번에는 단순히 복붙이 아니라 좀 더 개선할 수 있었다. Dismissible 위젯, showDialog 등을 개선하고 UI 의 코드들을 기능에 따라서 별도의 파일로 분리했다.

<br>

<참고>

https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692

https://github.com/vaygeth89/reactive_flutter_todo_database_app

https://api.flutter.dev/flutter/widgets/Dismissible-class.html

https://api.flutter.dev/flutter/material/showDialog.html

https://nurozkaya.medium.com/keyboard-pushes-the-content-up-resizes-the-screen-problem-in-flutter-59188a19324a

https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t

