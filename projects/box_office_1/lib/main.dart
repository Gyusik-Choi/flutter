import 'package:box_office_1/bloc/movie_bloc.dart';
import 'package:box_office_1/bloc/movie_provider.dart';
import 'package:box_office_1/repository/movie_api.dart';
import 'package:box_office_1/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      movieBloc: MovieBloc(MovieAPI()),
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}
