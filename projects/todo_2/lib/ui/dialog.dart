import 'package:flutter/material.dart';

Future deleteDialog(BuildContext context) {
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

Future serverErrorDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '서버 에러가 발생했습니다',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )
        ),
        actions: [
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