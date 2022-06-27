# ListTile 클릭 효과 (ripple)

ListTile 의 onTap 속성을 작성하면 (구체적인 콜백 함수를 작성하지 않아도) 마치 InkWell 처럼 클릭했을 경우 클릭 했음을 알 수 있는 물결 퍼지는 효과가 나타난다.

이때 주의할점은 만약에 ListTile 에 BoxDecoration 주기 위해 상위에 Container 를 두고 Container 에 decoration 키의 값으로 BoxDecoration 을 설정하면 ListTile 의 클릭 효과가 Container 의 BoxDecoration 에 의해 덮여서 나타나지 않는다.

해결방법은 ListTile 에 shape 을 통해서 효과를 주면 된다.

<br>

before

```dart
Container(
  decoration: const BoxDecoration(
    color: Color(0xff5664cd),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50),
      bottomLeft: Radius.circular(50),
    )
  ),
  child: ListTile(
  	onTap: () {},
  )
)
```

<br>

after

```dart
Container(
  child: ListTile(
  	shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      	topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      )
    ),
    onTap: () {},
  )
)
```

<br>

<참고>

https://stackoverflow.com/questions/69073736/is-it-possible-to-set-a-border-for-listtile-flutter

