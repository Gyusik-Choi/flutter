import 'dart:async';

import 'package:box_office_1/repository/movie_api.dart';

class MovieBloc {
  final MovieAPI movieAPI;

  MovieBloc(this.movieAPI);

  final StreamController _controller = StreamController();
  Stream get movies => _controller.stream;

  Future<void> getMovies() async {
    await movieAPI.getMovies();
  }

  void dispose() {
    _controller.close();
  }
}