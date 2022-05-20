# Flutter .ENV

flutter_dotenv 플러그인 설치

https://pub.dev/packages/flutter_dotenv

<br>

pubspec.yaml 의 asset에 등록

```
assets:
- .env
```

<br>

main 함수에서 초기화

```dart
Future<void> main() async {
    ...
	await dotenv.load(fildName: '${env파일 이름}');
    ...
}
```

<br>

원하는 곳에서 사용

```dart
String yourKey = dotenv.get('${env파일에서 가져올 키}');
```

