# DropdownButton - full width 설정

Flutter 에서 DropdownButton 의 영역은 기본적으로 DropdownButton 에 속하는 DropdownMenuItem 의 value 최대 길이에 맞춰서 설정된다.

만약에 DropdownButton 을 가로 영역을 꽉 채운 길이로 나타내고 싶다면 간단하게 설정할 수 있다. DropdownButton 에 isExpanded 라는 속성을 true 로 설정해주면 된다.

```dart
DropdownButton(
  isExpanded: true,
)
```

<br>

<참고>

https://stackoverflow.com/questions/51841400/full-width-dropdownbutton-with-adjust-dropdown-arrow-icon-in-flutter

