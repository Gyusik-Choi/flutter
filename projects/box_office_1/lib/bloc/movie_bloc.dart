import 'dart:async';

import 'package:box_office_1/model/movie.dart';
import 'package:box_office_1/repository/movie_api.dart';

class MovieBloc {
  final MovieAPI movieAPI;

  MovieBloc(this.movieAPI);

  final StreamController _controller = StreamController();
  Stream get movies => _controller.stream;

  Future<void> getMovies() async {
    List<Movie> movies = await movieAPI.getMovies();
    _controller.add(movies);
  }

  void dispose() {
    _controller.close();
  }
}