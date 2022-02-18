import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'network_connectivity.dart';
import 'objects.dart';

class DioSingleton {
  static const String BASE_URL_DEBUG = "http://.../api/v1/";
  static const String BASE_URL_RELEASE = "http://.../api/v1/";


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
  late Dio dio;

  String tag = "API call :";

  void update(String? auth) {
    BaseOptions options = BaseOptions(
      headers: {
        "Authorization": "Bearer $auth",
        "Accept":"application/json",
        "Content-Type":"application/json",
      },
      baseUrl: baseURL(),
      connectTimeout: 100000,
      receiveTimeout: 100000,
      followRedirects: false,
    );
    dio.options = options;
  }

  void create() {
    BaseOptions options = BaseOptions(
      headers: {
        "Accept":"application/json",
        "Content-Type":"application/json",
      },
      baseUrl: baseURL(),
      connectTimeout: 100000,
      receiveTimeout: 100000,
      followRedirects: false,
    );

    dio = Dio(options);

    dio.interceptors
      ..add(dioLoggerInterceptor)
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          networkConnectivity.checkStatus();
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          // if (e.response?.statusCode != null && e.response?.statusCode == 401) {
          //   await authBloc.logOut(expired: true);
          //   return locator<NavigationService>()
          //       .navigateToLogout(OnBoardingScreen.routeName);
          // } else return handler.reject(e);
          return handler.reject(e);
        },
      ))
      ..add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        error: true,
      ));
  }
}

Future postHttp(String path, {dynamic data, CancelToken? cancelToken}) =>
    DioSingleton.instance.dio.post(path, data: data, cancelToken: cancelToken);

Future putHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.put(path, data: data);

Future deleteHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.delete(path);

Future getHttp(String path) => DioSingleton.instance.dio.get(path);
