class Favorite {
  late String title;
  late String? type;

  Favorite({required this.title, required this.type});

  Favorite.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
