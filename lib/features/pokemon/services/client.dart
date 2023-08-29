import 'package:dio/dio.dart';

import '../../../core/consts/const.dart';

class RestApi {
  late Dio dio;

  BaseOptions options = BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: const Duration(seconds: 10),
  );

  RestApi() {
    dio = Dio(options);
    dio.interceptors
        .add(LogInterceptor(requestHeader: true, responseBody: true));
  }

  Dio get client => dio;
}
