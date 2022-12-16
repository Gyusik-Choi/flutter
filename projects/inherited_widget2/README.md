# inherited_widget2

### 주제

[flutter 공식 문서](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)의 [provider 플러그인](https://pub.dev/packages/provider) 을 이용한 상태관리 예제를 provider 없이 inherited widget 을 이용하여 구현했다.

<br>

### 핵심 구현 사항

#### stateful widget + inherited widget

provider 대신 inherited widget 을 감싼 stateful widget 을 material app 위에 두면서 material app 아래의 어떠한 위젯에서도 해당 inherited widget 의 데이터에 접근할 수 있도록 했다.

```
stateful widget
- inherited widget
- - material app
```

<br>

inherited widget 을 사용하면서 한 개가 아닌 여러 개의 inherited widget 은 어떻게 사용할 수 있을지 궁금했다. 이에 대한 궁금증을 이번 프로젝트를 통해 어느정도 해소할 수 있었다.

provider 에 multi provider 클래스가 있는데 provider 를 여러개를 보다 쉽게 정의하고 사용할 수 있도록 도와주는 기능을 한다.

multi provider 는 [nested 플러그인](https://pub.dev/packages/nested)을 이용해서 여러개의 provider 를 child 형태가 아닌 배열의 아이템으로 나열할 수 있도록 했다.

<br>

[공식문서의 multi provider 예시](https://pub.dev/packages/provider#multiprovider)는 아래와 같다.

From

```dart
Provider<Something>(
  create: (_) => Something(),
  child: Provider<SomethingElse>(
    create: (_) => SomethingElse(),
    child: Provider<AnotherThing>(
      create: (_) => AnotherThing(),
      child: someWidget,
    ),
  ),
),
```

To

```dart
MultiProvider(
  providers: [
    Provider<Something>(create: (_) => Something()),
    Provider<SomethingElse>(create: (_) => SomethingElse()),
    Provider<AnotherThing>(create: (_) => AnotherThing()),
  ],
  child: someWidget,
)
```

<br>

부모 자식 간의 관계로 여러개의 provider 를 연결한 것을 보고, nested 플러그인을 사용하지 않으면 child 형태로 inherited widget 을 여러개 둘 수 있겠다고 생각했다.

inherited widget 을 감싼 stateful widget 을 하나 더 생성하여 부모 자식 관계로 연결했다.

```
stateful widget
- inherited widget
- - stateful widget
- - - inherited widget
- - - - material app
```

<br>

프로젝트에 inherited widget 과 이를 감싼 stateful widget 이 각각 2개씩 있다. 

CartOutsideStateful, CartStateful 이 stateful widget 인데 material app 위에 child 로 연결했다.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartOutsideStateful(
      child: CartStateful(
        child: MaterialApp(),
      ),
    );
  }
}
```

<br>

### why stateful widget + inherited widget? 

inherited widet 만으로는 상태 변화를 화면에 반영할 수 없다. 

이에 대한 내용은 [provider 작성자의 stackoverflow 답변](https://stackoverflow.com/questions/60041554/how-to-call-setstate-or-update-value-in-inheritedwidget)에 잘 나와있다. inherited widget 은 update 가 됐음을 widget 에 알릴 수가 없어서 화면을 rebuild 할 수가 없다. 

화면을 다시 그려주기 위해 stateful widget 의 도움을 받아야 한다. 특히 [setState](https://api.flutter.dev/flutter/widgets/State/setState.html) 와 [didChangeDependencies](https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html) 를 활용해서 구현해야 한다.

