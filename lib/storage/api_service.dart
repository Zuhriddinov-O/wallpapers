import "dart:convert";
import "package:http/http.dart" as http;
import "package:wallpapers/storage/wallpapers.dart";

const baseUrl = "https://api.pexels.com/v1";
const String accessKey = 'lS8jhW3h1jjqdTyQWqO5IkUuDNrvGRDIZuZV95ThgkNrIO3zGsvIu8SR';

abstract class ApiService {
  Future<List<Wallpapers>?> getWallpapers();

  Future<void> delete(String? id);

  Future<void> update(String? id);
}

class ApiServiceImpl extends ApiService {
  @override
  Future<void> delete(String? id) async {
    final response = await http.delete(Uri.parse("$baseUrl/curated?page"));
  }

  @override
  Future<List<Wallpapers>?> getWallpapers() async {
    final response = await http.get(
        Uri.parse(
          "$baseUrl/curated?page=1",
        ),
        headers: {'Authorization': 'Client-ID $accessKey'});
    if (response.statusCode == 200) {
      final jsonString = json.decode(response.body) as List;
      return jsonString.map((e) => Wallpapers.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> update(String? id) async {
    final response = await http.put(Uri.parse("$baseUrl?page=2"));
  }
}
// CZVZPQKrG7OE_N6cP4d1hLfq5mg96XEhKkfGbUu2dR0 Access Key
// sZI0wJx9kSbL457nssj-qRbRYHgUr8Sejh4iSzQ6a4w Secret Key
// 582390 Aplication ID
