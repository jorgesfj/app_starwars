import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = "https://swapi.dev/api/people/";

class APICharacter {
  static Future getCharacter() async {
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }
}

class Character {
  late String title;

  Character({required this.title});

  Character.fromJson(Map<String, dynamic> json) {
    title = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.title;
    return data;
  }
}
