import 'package:flutter/material.dart';
import 'package:inherited_widget3/model/todo.dart';
import 'package:inherited_widget3/state/todo_stateful.dart';

Future addTodo(BuildContext context, TodoStatefulState state) {
  final TextEditingController controller = TextEditingController();
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
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: height * 0.3,
          child: Padding(
            padding: EdgeInsets.only(
              top: width * 0.02,
              right: width * 0.01,
              bottom: width * 0.025,
              left: width * 0.01,
            ),
            child: ListView(
              children: <Widget> [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        textInputAction: TextInputAction.newline,
                        autofocus: true,
                        maxLines: 3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'New Todo',
                        ),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.01,
                        top: width * 0.02,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            String words = controller.value.text;

                            if (words.isNotEmpty) {
                              final Todo newTodo = Todo(
                                description: words,
                              );

                              await state.addTodo(newTodo);

                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            }
                          },
                        )
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}