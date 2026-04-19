import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../Model/post_model.dart';

class ApiRepository {
  Future<List<PostModel>> getPostApi({int? page}) async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => PostModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Exception : ${e.toString()}");
      return [];
    }
  }
}
