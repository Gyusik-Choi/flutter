import 'package:flutter/material.dart';

Future addTodo(BuildContext context) {
  final TextEditingController _controller = TextEditingController();
  Size size = MediaQuery.of(context).size;
  double width = size.width;
  double height = size.height;

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      // https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t
      // Container 로 감싸고 있던 것을 Padding 으로 바꾸고 그 안에 SizedBox 를 넣었다
      // Padding 의 padding 에 MediaQuery.of(context).viewInsets 값을 주어서
      // keyboard 가 ModalBottomSheeet 를 가리지 않도록 한다
      // 다만 Container 안에 padding: MediaQuery.of(context).viewInsets 를 선언하면 적용되지 않았다
      // 대신 Padding 안에 padding: MediaQuery.of(context).viewInsets 를 선언하니 적용됐다
      // 그리고 height 값은 keyboard 위에 보이는 영역의 높이 값으로 지정할 수 있다
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: height * 0.1,
          child: ListView(
            children: <Widget> [
              Row(
                children: <Widget> [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      autofocus: true,
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  );
}