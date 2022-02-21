import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ApiProvider {

  String url = "https://jsonplaceholder.typicode.com/posts?_page=";

  Future<List<dynamic>> getPosts(int pageNum) async {
    try {
        http.Response response = await http.get(Uri.parse(url + pageNum.toString()));
        List<dynamic> responseBody = await json.decode(response.body);
        List<ApiModel> posts = responseBody.map((item) => ApiModel.fromJson(item)).toList();
        return posts;
        // Iterable responseBody = await json.decode(response.body);
        // List<ApiModel> posts = responseBody.map((model) => ApiModel.fromJson(model)).toList();
    } catch(error) {
      return [error];
    }

  }
}