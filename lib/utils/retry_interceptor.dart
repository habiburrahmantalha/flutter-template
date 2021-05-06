// import 'dart:async';
// import 'dart:io';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// class RetryOnConnectionChangeInterceptor extends Interceptor {
//   final DioConnectivityRequestRetrier requestRetrier;
//
//   RetryOnConnectionChangeInterceptor({
//     @required this.requestRetrier,
//   });
//
//   @override
//   Future onError(DioError err) async {
//     if (_shouldRetry(err)) {
//       try {
//         return requestRetrier.scheduleRequestRetry(err.request);
//       } catch (e) {
//         // Let any new error from the retrier pass through
//         return e;
//       }
//     }
//     // Let the error pass through if it's not the error we're looking for
//     return err;
//   }
//
//   bool _shouldRetry(DioError err) {
//     return err.type == DioErrorType.DEFAULT &&
//         err.error != null &&
//         err.error is SocketException;
//   }
// }
//
// class DioConnectivityRequestRetrier {
//   final Dio dio;
//   final Connectivity connectivity;
//
//   DioConnectivityRequestRetrier({
//     @required this.dio,
//     @required this.connectivity,
//   });
//
//   Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
//     StreamSubscription streamSubscription;
//     final responseCompleter = Completer<Response>();
//
//     streamSubscription = connectivity.onConnectivityChanged.listen(
//       (connectivityResult) async {
//         if (connectivityResult != ConnectivityResult.none) {
//           streamSubscription.cancel();
//           // Complete the completer instead of returning
//           responseCompleter.complete(
//             dio.request(
//               requestOptions.path,
//               cancelToken: requestOptions.cancelToken,
//               data: requestOptions.data,
//               onReceiveProgress: requestOptions.onReceiveProgress,
//               onSendProgress: requestOptions.onSendProgress,
//               queryParameters: requestOptions.queryParameters,
//               options: requestOptions,
//             ),
//           );
//         }
//       },
//     );
//
//     return responseCompleter.future;
//   }
// }
