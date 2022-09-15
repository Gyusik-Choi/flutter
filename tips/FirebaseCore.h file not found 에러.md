# 'FirebaseCore/FirebaseCore.h' file not found 에러

iOS 에서 시뮬레이터로 플러터 앱을 실행시키려 했는데 위의 에러가 발생했다.

앱스토어 심사 제출을 위해 Product -> Scheme -> Edit Scheme -> Run -> Info -> Build Configuration -> release 상태였는데 release 를 debug 로 수정하니 해결됐다.

시뮬레이터로 앱을 실행하려면 스키마를 debug 로 두어야 한다.