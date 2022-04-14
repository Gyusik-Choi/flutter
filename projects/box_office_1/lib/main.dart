import 'package:box_office_1/repository/movie_api.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  MovieAPI movieApi = MovieAPI();
  await movieApi.getMovies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(),
    );
  }
}
