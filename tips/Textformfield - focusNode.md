# TextFormField - focusNode

TextFormField 의 focus 를 해제할때 키보드의 완료 버튼을 누르지 않고도 바깥 영역을 클릭하는 방법을 이용할 수도 있는데 이를 구현하기 위해서 focusNode 를 사용할 수 있다.

<br>

FocusNode 인스턴스를 생성한다.

```dart
FocusNode focusNode = FocusNode();
```

<br>

FocusNode 인스턴스에 addListener 를 등록한다.

```dart
focusNode.addListener(focusNodeListener)

void focusNodeListener() {
  // focus 잡혔을 때
  if (focusNode.hasFocus) {
    
  // focus 해제됐을 때
  } else {
    
  }
}
```

<br>

FocusNode 인스턴스의 focus 를 해제하기 위해 페이지 전체에서 클릭을 듣고 focus 를 해제하도록 Scaffold 위젯을 GestureDetector 로 감싸고 onTap 프로퍼티에 unfocus 메소드를 등록한다.

```dart
class A extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        
      )
    );
  }
}


```

<br>

<참고>

https://stackoverflow.com/questions/68675718/how-can-i-catch-event-when-a-text-field-is-exiting-focus-on-blur-in-flutter

https://annhee.tistory.com/72