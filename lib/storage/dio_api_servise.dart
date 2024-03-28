import "package:dio/dio.dart" hide Headers;
import "package:pretty_dio_logger/pretty_dio_logger.dart" ;
import "package:wallpapers/storage/url_storage.dart";
import "package:wallpapers/storage/wallpapers.dart";
import 'package:retrofit/retrofit.dart';

part 'dio_api_servise.g.dart';

@RestApi()
abstract class DioApiService {
  factory DioApiService(Dio dio, {String baseUrl}) = _DioApiService;

  @Headers({
    "Authorization": Constants.accessKey
  })
  @GET("curated?page=2")
  Future<Wallpapers> getWallpapers();
}

Dio buildDioClient(String baseUrl) {
  final dio = Dio()..options = BaseOptions(baseUrl: baseUrl);
  dio.interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      request: true,
      responseHeader: true,
      maxWidth: 90,
    )
  ]);
  return dio;
}
