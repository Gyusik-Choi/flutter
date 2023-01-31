# GetX - Rx

### .obs

```dart
Rx<String> name = 'Bill'.obs;
```

GetX 에서 Rx 타입의 값을 생성할 때 .obs 를 사용할 수 있다.

<br>

```dart
// https://github.com/jonataslaw/getx/blob/4.6.5/lib/get_rx/src/rx_types/rx_core/rx_impl.dart

abstract class _RxImpl<T> extends GetListenable<T> with RxObjectMixin<T> {
  _RxImpl(T initial) : super(initial);
  ...
}

class RxBool extends Rx<bool> {
  RxBool(bool initial) : super(initial);
  ...
}

class RxnBool extends Rx<bool?> {
  RxnBool([bool? initial]) : super(initial);
  ...
}

extension RxBoolExt on Rx<bool> {
  ...
}

extension RxnBoolExt on Rx<bool?> {
  ...
}

/// Foundation class used for custom `Types` outside the common native Dart
/// types.
/// For example, any custom "Model" class, like User().obs will use `Rx` as
/// wrapper.
class Rx<T> extends _RxImpl<T> {
  Rx(T initial) : super(initial);
  ...
}

class Rxn<T> extends Rx<T?> {
  Rxn([T? initial]) : super(initial);
  ...
}

extension StringExtension on String {
  /// Returns a `RxString` with [this] `String` as initial value.
  RxString get obs => RxString(this);
}

extension IntExtension on int {
  /// Returns a `RxInt` with [this] `int` as initial value.
  RxInt get obs => RxInt(this);
}

extension DoubleExtension on double {
  /// Returns a `RxDouble` with [this] `double` as initial value.
  RxDouble get obs => RxDouble(this);
}

extension BoolExtension on bool {
  /// Returns a `RxBool` with [this] `bool` as initial value.
  RxBool get obs => RxBool(this);
}

extension RxT<T> on T {
  /// Returns a `Rx` instance with [this] `T` as initial value.
  Rx<T> get obs => Rx<T>(this);
}
```

위는 GetX 4.6.5 버전의 소스코드 일부다.

<br>

아까 위에서 선언한

```dart
Rx<String> name = 'Bill'.obs;
```

이 코드가 가능한 이유는 String 클래스에 대한 extension 으로 getter 인 obs 가 선언되어 있는데 이 obs 는 RxString(this) 를 반환하기 때문이다. 

RxString 은 Rx< T > 클래스를 구현한 클래스다.

<br>

```dart
/// Rx class for `String` Type.
class RxString extends Rx<String> implements Comparable<String>, Pattern {
  RxString(String initial) : super(initial);

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) {
    return value.allMatches(string, start);
  }

  @override
  Match? matchAsPrefix(String string, [int start = 0]) {
    return value.matchAsPrefix(string, start);
  }

  @override
  int compareTo(String other) {
    return value.compareTo(other);
  }
}

```

RxString 클래스는 제네릭 형태의 Rx 클래스인 Rx< T > 클래스를 구현했다.

<br>

### Rx< T > 에서 Rx 제거

Rx< T > 변수는 Rx 를 제거하고 T 만 남길 수 있다.

<br>

```dart

```

<br>

```dart
Rx<Person> person = Person('Bill').obs;

print(person().runtimeType);
// Person
print(person.runtimeType);
// Rx<Person>

Rx<String> name = 'Bill'.obs;

print(name().runtimeType);
// String
print(name.runtimeType);
// Rx<String>
```

위의 Person 클래스의 인스턴스를 .obs 로 생성하여 Rx< Person > 타입으로 생성하여 변수 person 에 할당했다.

person 은 person() 이렇게 선언할 수 있고, 이렇게 하면 Rx 가 제거된 Person 타입이 된다.

~~이게 어떻게 가능한지는 아직 의문이다...~~

