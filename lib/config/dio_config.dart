import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConfig {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakeapi.platzi.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            debugPrint('DIO Request: ${options.method} ${options.uri}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint('DIO Response [${response.statusCode}] ${response.requestOptions.uri}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            debugPrint('DIO Error: ${error.requestOptions.uri}');
          }
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}
