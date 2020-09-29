import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/utils/retry_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'network_connectivity.dart';
import 'objects.dart';
import 'utils.dart';

class DioSingleton {
  static const String BASE_URL_DEBUG = "http://--/api/v1/";
  static const String BASE_URL_RELEASE = "http://--/api/v1/";


  baseURL() {
    if (staging) {
      return BASE_URL_DEBUG;
    } else if (kReleaseMode) {
      return BASE_URL_RELEASE;
    } else {
      return BASE_URL_DEBUG;
    }
  }

  static final DioSingleton _singleton = new DioSingleton._internal();

  DioSingleton._internal();

  static DioSingleton get instance => _singleton;
  Dio dio;

  String tag = "API call :";

  void update(String auth) {
    BaseOptions options = new BaseOptions(
      headers: {"Authorization": "Bearer $auth"},
      baseUrl: baseURL(),
      connectTimeout: 100000,
      receiveTimeout: 100000,
    );
    dio.options = options;
  }

  void create() {
    BaseOptions options = new BaseOptions(
      baseUrl: baseURL(),
      connectTimeout: 100000,
      receiveTimeout: 100000,
    );

    dio = new Dio(options);

    dio.interceptors
      ..add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: false))
      ..add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          networkConnectivity.checkStatus();
          // print("Dio Request");
          // print(options.headers);
          // printLarge("${options.data}");
          // print(options.contentType);
          // print(options.extra);
          // print(options.baseUrl + "" + options.path);
          return options;
        },
        onResponse: (Response response) {
          // print("Dio Success Response");
          // printLarge("${response.data}");
          // print(response.extra);
          return response;
        },
        onError: (DioError e) {
          // print("Dio Error Response");
          // printLarge("${e.response}");
          // print(e.message);
          // print(e.type);
          return e;
        },
      ))
      ..add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      )
      ..add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        error: true,
      ));
  }
}

Future postHttp(String path, {dynamic data, CancelToken cancelToken}) =>
    DioSingleton.instance.dio.post(path, data: data, cancelToken: cancelToken);

Future putHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.put(path, data: data);

Future deleteHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.delete(path);

Future getHttp(String path) => DioSingleton.instance.dio.get(path);
