# TextFormField - 커서가 맨 앞으로 가는 현상 해결

처음 입력이 아니라 기존에 입력한 내용을 서버에서 불러와서 TextFormField 에 표시했을 때 클릭하여 커서가 생기면 글자의 맨 마지막이 아니라 맨 앞으로 가는 현상이 발생했다.

이를 위해 TextFormField 에 등록한 controller 의 selection 프로퍼티의 값으로 TextSelection 설정을 하여 해결할 수 있었다.

```dart
textFormFieldController.selection = TextSelection(
	baseOffSet: '초기값으로 설정한 글자의 길이',
  	extentOffSet: '초기값으로 설정한 글자의 길이',
);
```



<br>

<참고>

https://stackoverflow.com/questions/56851701/how-to-set-cursor-position-at-the-end-of-the-value-in-flutter-in-textfield

