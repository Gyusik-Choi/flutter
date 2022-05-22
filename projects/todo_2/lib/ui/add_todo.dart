import 'package:flutter/material.dart';

Future addTodo(BuildContext context) {
  final TextEditingController _controller = TextEditingController();
  Size size = MediaQuery.of(context).size;
  double width = size.width;
  double height = size.height;

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: height * 0.5,
        padding: EdgeInsets.all(width * 0.03),
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
      );
    }
  );
}