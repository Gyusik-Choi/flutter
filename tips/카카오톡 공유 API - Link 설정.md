# 카카오톡 공유 API - Link 설정

카카오에서 플러터에서 활용할 수 있는 다양한 API들을 제공해주는데 그 중 카카오톡 공유 기능을 활용하면서 Link 설정시 주의할점은 기록으로 남겨두려 한다.

먼저 카카오톡 공유는 카카오에서 제공해주는 메시지 API 의 두가지 방식 중 하나다. 메시지 API 는 카카오톡 공유 API, 카카오톡 메시지 API 두개로 나뉘며 이번에 사용한 기능은 카카오톡 공유 API 다. 둘의 차이는 [이곳](https://developers.kakao.com/docs/latest/ko/message/common#intro)을 참고하면 된다.

<br>

카카오톡 공유 API 를 활용하면 기본 메시지 템플릿 혹은 사용자 정의 템플릿을 사용할 수 있다. [기본 메시지 템플릿](https://developers.kakao.com/docs/latest/ko/message/message-template#component)도 다양한 템플릿들을 제공해준다. 기본 메시지 템플릿에서 공통적인 구성 요소가 있는데 그 중 하나가 [링크(Link)](https://developers.kakao.com/docs/latest/ko/message/message-template#link) 다. 메시지를 클릭했을 때 이동할 수 있는 링크 기능을 담당한다.

이때 주의할점이 있는데, 코드 상에 link 주소를 기입하지만 <u>이 주소는 반드시 kakao developers 사이트의 플랫폼의 Web 에서 사이트 도메인으로 등록</u>이 되어야 한다.

링크로 원했던 도메인 URL 이 계속해서 변하는 문제가 있었으나 등록해야 하는 도메인이 full path 로 기재해야 하는것은 아니다. 링크는 크게 Domain 과 Path 로 구분되어서 등록해야하는 부분은 Domain 부분이다.

링크를 걸기를 원하는 주소가 https://developers.kakao.com/docs 라면 https://developers.kakao.com 까지만 도메인으로 등록하면 된다.

카카오톡 공유 API 하면서 구현하고자 했던 기능은 플러터 앱의 위젯을 이미지로 변환해서 카카오톡으로 공유하는 기능이다. 카카오톡 공유 API 로 이미지를 전송하려면 기기내의 경로로는 안되고 URL 형태여야 한다. 이를 위한 기능도 카카오에서 제공해준다. 카카오 이미지 서버로 이미지를 전송하면 이 이미지의 URL 을 리턴해주고 이 값을 활용할 수 있다. 

이 기능을 활용하려면 앞서 언급한 것처럼 kakao developers 사이트에 도메인을 등록 해야하는데 문제는 이미지를 전송할 때마다 URL 도 매번 바뀐다. 동적으로 저장할 수도 없는데 다행히 앞서 언급한 것과 마찬가지로 Domain 부분만 적고 하위의 변동되는 Path 를 코드 상에 작성하면 된다. 만약에 https://abcde.com/photo.png 라는 URL 에서 https://abcde.com 이 변하지 않고 고정이고 photo.png 값만 바뀐다면 kakao developers 사이트에는 https://abcde.com 만 등록해주면 된다. 코드 상에는 photo.png 만 적으면 동작하는지는 해보지 않았으나 코드 상에 link 부분을 https://abcde.com/photo.png 로 full path 를 기재해도 정상적으로 동작했다.

<br>

<참고>

https://developers.kakao.com/docs/latest/ko/message/common#intro

https://developers.kakao.com/docs/latest/ko/message/message-template#component

https://developers.kakao.com/docs/latest/ko/message/message-template#link

https://developers.kakao.com/docs/latest/ko/message/message-template#component-link

https://webruden.tistory.com/354

