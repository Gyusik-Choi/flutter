# flutter 와 android SharedPreferences 공유

flutter 로 개발을 하면서 android 홈 화면 위젯을 만들 기회가 생겨서 네이티브 개발을 하게 됐다. flutter 로는 android 위젯을 만들 수 없다. java 혹은 kotlin 언어를 이용해서 네이티브로 개발해야 한다.

위젯을 개발하면서 flutter 에서 shared preferences 에 저장한 내용을 네이티브에서 확인 해야할 필요가 생겼고, 이를 정리하고자 이 글을 작성하게 됐다.

<br>

```dart
// shared_preferences.dart
class SharedPreferences {
  static const String _prefx = 'flutter.';
  
  Future<bool> setBool(String key, bool value) => _setValue('Bool', key, value);
  
  Future<bool> _setValue(String valueType, String key, Object value) {
    ArgumentError.checkNotNull(value, 'value');
    final String prefixedKey = '$_prefix$key';
    if (value is List<String>) {
      _preferenceCache[key] = value.toList();
    } else {
      _preferenceCache[key] = value;
    }
    return _store.setValue(valueType, prefixedKey, value);
  }
}
```

위는 flutter plugin 중 하나인 shared preferences 의 소스 코드 일부다.

shared preferences 는 key, value 형태로 값을 저장하는데 setBool 은 boolean 값을 저장하는 함수다. 

setBool 은 _setValue 함수를 호출하는데 _setValue 함수에서 prefixedKey 를 변수 _prefix 와 파라미터 key 를 합쳐서 생성한다. prefixedKey 가 'flutter.[key 로 넘어온 값]' 형태가 되어서 key 가 된다. 이렇게 prefixedKey 를 생성한 후에 setValue 함수를 호출하면서 인자로 넣어준다. 

<br>

```dart
// shared_preferences_android.dart
class SharedPreferencesAndroid extends SharedPreferencesStorePlatform {
  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    return (await _kChannel.invokeMethod<bool>(
      'set$valueType',
      <String, dynamic>{'key': key, 'value': value},
    ))!;
  }
}
```

_store.setValue 에서 setValue 함수는 **shared_preferences_platform_interface.dart** 에서 플랫폼 별로 생성한 인스턴스의 setValue 함수에 해당한다. android 환경에서는 **shared_preferences_android.dart** 의 setValue 함수를 호출하게 된다.

<br>

flutter 에서 shared preferences 에 값을 저장하면 앱 저장공간 내의 shared_prefs 폴더에 FlutterSharedPreferences.xml  파일이 생성된다.

android 에서 이 파일을 바라보도록 shared preferences 인스턴스를 생성하면 된다.

```java
public class SP {
  public Context context;
  public SharedPreferences prefs;
  
  public SP(Context context) {
    this.context = context;
    prefs = context.getSharedPreferences("FlutterSharedPreferences", 0);
  }
}
```

<br>

인스턴스를 생성한 후에 android 에서 key 로 value 에 접근할 때 key 이름 앞에 접두사 "flutter." 을 붙여야 한다. 예를 들어 flutter 에서 isAndroid 라는 key 로 생성한 값을 android 에서 접근하려면 아래와 같은 방법을 사용할 수 있다.

```java
prefs.getBool("flutter.isAndroid", false);
```

<br>

<참고>

https://pub.dev/packages/shared_preferences

https://github.com/flutter/plugins/blob/main/packages/shared_preferences/shared_preferences/lib/shared_preferences.dart

https://github.com/flutter/plugins/blob/main/packages/shared_preferences/shared_preferences_platform_interface/lib/shared_preferences_platform_interface.dart

https://github.com/flutter/plugins/blob/main/packages/shared_preferences/shared_preferences_android/lib/shared_preferences_android.dart

https://developer.android.com/training/data-storage/shared-preferences?hl=ko

