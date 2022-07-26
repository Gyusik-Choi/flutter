#  InkWell 위젯의 ripple 효과

InkWell 위젯 안에 Container 를 두고 배경색을 지정하면 ripple 효과가 Container 배경색에 덮여서 나타나지 않을 수 있다. 이때 해결방법은 Container 를 Ink 위젯으로 교체하고, InkWell 에 splashColor 속성으로 특정한 색상을 지정해주면 된다.

```dart
InkWell(
  splashColor: const Color(0xffffffff),
  child: Ink(
    color: const Color(0xffcacaca),
    width: width * 0.15,
    height: width * 0.15,
    child: const Icon(
      Icons.add,
      color: Color(0xffffffff),
    ),
  ),
  onTap: () {

  },
),
```

<br>

<참고>

https://stackoverflow.com/questions/45424621/inkwell-not-showing-ripple-effect