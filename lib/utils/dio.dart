import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/network/blocs/auth.dart';
import 'package:flutter_template/network/endpoints.dart';
import 'package:flutter_template/network/models/request.dart';
import 'package:flutter_template/network/models/response.dart';
import 'package:flutter_template/utils/retry_interceptor.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
    BaseOptions options = new BaseOptions(
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
    BaseOptions options = new BaseOptions(
      headers: {
        "Accept":"application/json",
        "Content-Type":"application/json",
      },
      baseUrl: baseURL(),
      connectTimeout: 100000,
      receiveTimeout: 100000,
      followRedirects: false,
    );

    dio = new Dio(options);

    dio.interceptors
      ..add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: true,
          error: true,
          compact: false))
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
