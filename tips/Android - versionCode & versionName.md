# versionCode, versionName

플러터의 버전 정보가 필요할 경우 [platform_info_plus](https://pub.dev/packages/package_info_plus) 플러그인을 통해 가져올 수 있다.

```dart
PackageInfo packageInfo = await PackageInfo.fromPlatform();
String version = packageInfo.version;
String buildNumber = packageInfo.buildNumber;

print(version); // 1.0.0
print(buildNumber); // 1
```

<br>

pubspec.yaml 에 버전 정보를 갖고 있는데 예를 들어 1.0.0+1 이라고 할때 안드로이드의 versionCode 가 +1 이 되고, versionName 이 1.0.0 이 된다.

안드로이드와 iOS 의 버전이 다를 수 있어서 pubspec.yaml 의 버전 정보가 아니라 각자 설정할 수 있는데 이 글에서는 안드로이드의 버전 설정을 정리하려고 한다.

android -> app -> build.gradle 을 보면 아래와 같다.

```groovy
defaultConfig {
  versionCode flutterVersionCode.toInteger()
  versionName flutterVersionName
}
```

<br>

플러터 설정 정보를 따르고 있는데 이를 다음과 같이 직접 수정할 수 있다.

```groovy
defaultConfig {
  versionCode 100
  versionName '2.0.0'
}
```

<br>

이렇게 설정을 하고서 (안드로이드 에뮬레이터 기준) 앱을 완전히 껐다가 다시 실행을 시키면

```dart
PackageInfo packageInfo = await PackageInfo.fromPlatform();
String version = packageInfo.version;
String buildNumber = packageInfo.buildNumber;

print(version); // 2.0.0
print(buildNumber); // 100
```

