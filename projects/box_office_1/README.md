# box_office_1

## stream, bloc 을 활용한 박스오피스 앱

### 개요

GetX를 사용하면서 상태, 라우팅, 의존성 등을 편하게 관리하는 장점이 있지만 Flutter의 핵심 개념들(widget tree, context, stateful widget 등)이 추상화되면서 이를 제대로 이해하지 못한채로 개발하고 있다는 느낌이 들었다.

반응형 프로그래밍과 Flutter 플러그인에 의존하지 않고 상태관리를 하는 방법에 대한 이해도를 높이고자 이번 (미니) 프로젝트를 진행하게 됐다.

프로젝트를 진행하면서 [이분](https://software-creator.tistory.com/13?category=681555)의 코드를 아주 많이 참고했다.

<br>

### 구현 사항

Imdb 사이트의 박스오피스 api를 활용해서 박스오피스 순위를 나타낸다. 박스오피스 데이터는 bloc 패턴을 통해 비즈니스 로직과 UI를 구분하여 stream을 통한 반응형으로 나타냈다.

bloc(bloc 패턴을 보다 편하게 구현할 수 있도록 하는 플러그인), provider, getx 등의 상태관리 플러그인을 활용하지 않고 Flutter에서 기본적으로 제공하는 Inherited Widget을 활용했다.

<br>

### 개발 과정 중 특이사항

스크롤이 안되는 현상이 있었다. [Flutter 공식 깃헙 Issue](https://github.com/flutter/flutter/issues/80794)를 살펴보니 SingleChildScrollView와 ListView가 모두 같은 방향으로 스크롤이 중첩 설정되어서 어떤 것으로 스크롤을 해야할지 플러터 엔진에서 판단하지 못한 것 같다. 이번 프로젝트에서 해결한 방법은 ListView의 스크롤을 막아서 SingleChildScrollView의 스크롤이 진행되도록 했다.

<br>

<참고>

https://software-creator.tistory.com/13?category=681555

https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692

https://imdb-api.com/api#BoxOffice-header

https://velog.io/@restnfeel/Flutter-환경설정-파일-적용-기본

https://stackoverflow.com/questions/59304242/inheritfromwidgetofexacttype-is-deprecated-use-dependoninheritedwidgetofexacttype

https://github.com/flutter/flutter/issues/80794
