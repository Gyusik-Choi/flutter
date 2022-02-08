import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/bamboo_model.dart';

class BambooProvider {
  String url = "https://jsonplaceholder.typicode.com/posts?_page=";

  Future<List<dynamic>> getPosts(int pageNumber) async {
    try {
      http.Response response = await http.get(Uri.parse(url + pageNumber.toString()));
      List<dynamic> responseBody = await json.decode(response.body);
      List<BambooModel> posts = responseBody.map((item) => BambooModel.fromJson(item)).toList();
      return posts;
    } catch (err) {
      return [err];
    }
  }
}