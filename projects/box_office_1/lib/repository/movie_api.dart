import 'dart:convert';
import 'package:box_office_1/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieAPI {
  String url = 'https://imdb-api.com/en/API/BoxOffice/';
  String key = dotenv.get('KEY');

  Future<List<Movie>> getMovies() async {
    http.Response response = await http.get(Uri.parse(url + key));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> movieItems = responseBody['items'];

    List<Movie> movies = [];
    for (int i = 0; i < movieItems.length; i++) {
      Map<String, dynamic> movieItem = movieItems[i];
      Movie movie = Movie.fromJson(movieItem);
      movies.add(movie);
    }

    return movies;
  }
}