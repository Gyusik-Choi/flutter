import 'package:intl/intl.dart';

// 함수명 앞에 _ 붙이면 외부에서 접근이 불가능하다.
// 여기서 외부의 의미는 다른 파일을 의미한다.
// Future<String> _getTime() async {

class CurrentTime {
  Future<String> getTime() async {
    // https://stackoverflow.com/questions/54299659/flutter-datetime-now-not-same-in-my-local-time
    var now = DateTime.now();
    String currentTime = DateFormat("h:mm a").format(now);
    return currentTime;
  }
}

