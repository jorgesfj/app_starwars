import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = "https://swapi.dev/api/films";

class API {
  static Future getMovies() async {
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }
}

class Movie {
  late String title;
  String type = "movie";

  Movie({required this.title, required this.type});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
