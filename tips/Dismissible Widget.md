# Dismissible Widget

swipe 를 할 수 있는 위젯이다.

Dismissible 의 프로퍼티인 onDismissed 와 confirmDismiss 간의 차이를 정리해두려 한다.

swipe 를 하면 confirmDismiss 콜백으로 받게 된다. 이때 return 해주는 bool 값에 따라 onDismissed 에 들어올지 안들어올지가 결정된다. true 를 return 하면 onDismissed 에 들어오고, false 를 return 하면 onDismissed 에 들어오지 않는다.

만약에 swipe 후에 alertDialog 를 띄워서 특정 기능 수행 여부를 묻고 이에 따라서 동작 여부를 결정하고자 한다면 confirmDismiss 에서 alertDialog 를 띄우고, alertDialog 에서 return 한 bool 값을 그대로 return 하면 true 일때 onDismissed 에서 특정 기능을 수행하고, false 이면 onDismissed 에서 들어가지 않기 때문에 특정 기능을 수행하지 않는다.

```dart
Dismissible(
	onDismissed: (direction) async {
        // confirmDismiss 의 return 값이 true 면 여기로 들어온다
    },
    confirmDismiss: (direction) async {
        bool result = await dialog(context);
        return result;
    }
)
    
Future dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
        	return AlertDialog(
            	actions: <Widget> [
                    TextButton(
                        child: Text('취소'),
                    	onPressed: () {
                            Navigator.of(context).pop(false);
                        }
                    ),
                    TextButton(
                        child: Text('확인'),
                        onPressed: () {
                            Navigator.of(context).pop(true);
                        }
                    )
                ]
        	);
        }

    );
}
```





