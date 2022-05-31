import 'package:flutter/material.dart';

Future dialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '삭제하시겠습니까?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )
        ),
        actions: [
          TextButton(
            child: const Text(
              '취소',
            ),
            onPressed: () {
              return Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              '확인',
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  );
}