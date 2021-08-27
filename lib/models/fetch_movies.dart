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
  late int episodeId;

  Movie({required this.title, required this.episodeId});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    episodeId = json['episode_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['episode_id'] = this.episodeId;
    return data;
  }
}
