class Favorites {
  int? id;
  int? photo_id;
  String? photographer;
  String? medium;
  String? liked;

  Favorites(
      {required this.id,
      required this.photo_id,
      required this.photographer,
      required this.medium,
      required this.liked});

  Favorites.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    photo_id = json['photo_id'],
    photographer = json['photographer'],
    medium = json['medium'],
    liked = json['liked'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['photo_id'] = photo_id;
    data['photographer'] = photographer;
    data['medium'] = medium;
    data['liked'] = liked;
    return data;
  }
}
