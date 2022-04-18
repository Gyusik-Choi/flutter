import 'package:box_office_1/bloc/movie_bloc.dart';
import 'package:box_office_1/repository/movie_api.dart';
import 'package:flutter/material.dart';

class MovieProvider extends InheritedWidget {
  final MovieBloc movieBloc = MovieBloc(MovieAPI());

  MovieProvider({ Key? key, required MovieBloc movieBloc, required Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MovieBloc of(BuildContext context) {
    // https://stackoverflow.com/questions/59304242/inheritfromwidgetofexacttype-is-deprecated-use-dependoninheritedwidgetofexacttyp
    return (context.dependOnInheritedWidgetOfExactType<MovieProvider>() as MovieProvider).movieBloc;
  }
}