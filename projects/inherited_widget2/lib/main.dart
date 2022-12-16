import 'package:flutter/material.dart';
import 'package:inherited_widget2/state/cart_outside_state_ful.dart';
import 'package:inherited_widget2/state/cart_state.dart';
import 'package:inherited_widget2/state/cart_state_ful.dart';
import 'package:inherited_widget2/ui/cart.dart';
import 'package:inherited_widget2/ui/catalog.dart';
import 'package:inherited_widget2/ui/home.dart';

// https://stackoverflow.com/questions/61187248/flutter-how-should-i-use-an-inheritedwidget
// https://stackoverflow.com/questions/60041554/how-to-call-setstate-or-update-value-in-inheritedwidget
// https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
// https://pub.dev/packages/provider
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // InheritedWidget 2개를 사용했다
    // Provider 패키지에서 
    // MultiProvider 를 child 형태로 이어지는 것을 
    // Nested 플러그인으로 풀어낸 것을 보고
    // Nested 플러그인을 사용하지 않으면
    // child 로 InheritedWidget 을 쌓으면 
    // 여러개의 InheritedWidget 을 사용할 수 있겠다고 생각했다
    // CartOutsideStateful, CartStateful 는 각각
    // CartOutsideState, CartState 를 감싼 StatefulWidget 이다
    // InheritedWidget 은 업데이트를 발생시킬 수 없고 데이터를 갖고 있을 수만 있어서
    // 이를 위해서는 StatefulWidget 등으로 감싸서 사용해야 한다
    // 아래는 stackoverflow 의 Provider 작성자의 답변 내용이다
    // 
    // InheritedWidgets cannot do that. 
    // They are completely immutable with no mechanism for triggering updates.
    // If you want to emit updates, 
    // you will have to combine your InheritedWidget with a StatefulWidget, 
    return CartOutsideStateful(
      child: CartStateful(
        child: MaterialApp(
          initialRoute: '/cart_stateful',
          routes: {
            '/cart_stateful': (context) => CartStateful(child: CartState(data: CartStatefulState(), child: const Home(),)),
            '/catalog': (context) => const Catalog(),
            '/cart': (context) => const Cart(),
          }
        ),
      ),
    );
  }
}
