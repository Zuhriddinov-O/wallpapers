import 'package:wallpapers/storage/dio_api_servise.dart';
import 'package:wallpapers/storage/url_storage.dart';
import 'package:wallpapers/storage/wallpapers.dart';

abstract class DioRepository {
  Future<List<Photos>> getPhotos();
}

class DioRepositoryImpl extends DioRepository {
  final _dioApi = DioApiService(buildDioClient(Constants.baseUrl));

  @override
  Future<List<Photos>> getPhotos() async {
    try {
      final dioPhotoResponse = await _dioApi.getWallpapers();
      return dioPhotoResponse.photos ?? [];
    } catch (e) {
      return [];
    }
  }
}
