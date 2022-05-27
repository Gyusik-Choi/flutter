# table_calendar

https://pub.dev/packages/table_calendar

<br>

### 플러그인 기본 구조

TableCalendar 안에 TableCalendarBase 가 있고, TableCalendarBase 안에 TableCalendarCore 가 있다.

<br>

### 이슈

#### time zone

아무 날짜도 클릭 안하고 그대로 일정을 추가하면 eventLoader 에서 event 를 가져오질 못한다. event 를 가져와야 marker를 그릴 수 있다. event 를 가져올 수 있도록 해야 한다.

왜 위의 상황에서 일정을 못가져왔나 했는데, widget이 build 되기 전에 내가 설정한 selectedDay 는 local time zone 이었고, 플러그인에서는 UTC time zone 을 사용한다. 만약에 다른 날짜를 클릭한 후에 다시 처음 설정한 날짜를 누르면 이때는 플러그인에 의해서 UTC time zone 으로 selectedDay 가 변환된다. 내가 보기에는 같은 날짜를 선택했다고 하지만 실제로는 2022-05-26 00:00:00.000 에서 2022-05-26 00:00:00.000Z 로 변환됐다(뒤의 Z를 주목).

이벤트를 추가하면 객체 형태로 이벤트를 담는 배열에 추가가 된다. 객체의 키는 날짜가 되고 값이 이벤트 내용이다. 아무 날짜로 클릭 하지 않고 이벤트를 추가하면 키가 되는 날짜가 local time zone 으로 들어가게 된다. 플러그인에서는 (날짜 뷰를 month 로 설정했을 경우) 한 달의 모든 날짜를 돌면서 그 날짜의 이벤트가 있으면 markerBuilder 에 의해서 해당 날짜에 이벤트 marker가 표시된다. 플러그인에서는 날짜를 돌면서 매 날마다 이벤트를 불러오는 과정도 거치는데 이를eventLoader 에서 수행하고 eventLoader 에 UTC time zone 의 날짜를 인자로 넣어줘서 이 인자 값을 이벤트 정보 객체의 키로 사용한다. 이 키는 UTC time zone 의 시간이고 위에서 저장된 이벤트의 키는 local time zone 이라 event 자체를 불러올 수가 없었다.