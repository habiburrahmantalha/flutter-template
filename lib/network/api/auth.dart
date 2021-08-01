import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_template/network/endpoints.dart';
import 'package:flutter_template/network/models/request.dart';
import 'package:flutter_template/network/models/response.dart';
import 'package:flutter_template/utils/dio.dart';


class AuthApi {
    Future<ResponseRegister> register(RequestRegister requestRegister) async {
        Response response = await (postHttp(Endpoints.register(), data: requestRegister) as FutureOr<Response<dynamic>>);
        return ResponseRegister.fromJson(response.data);
    }

    Future<ResponseLogin> login(RequestLogin requestLogin) async {
        Response response = await (postHttp(Endpoints.login(), data: requestLogin) as FutureOr<Response<dynamic>>);
        return ResponseLogin.fromJson(response.data);
    }

    Future<ResponseUpdatePassword> updatePassword(RequestUpdatePassword updatePassword) async {
        Response response = await (postHttp(Endpoints.changePassword(), data: updatePassword) as FutureOr<Response<dynamic>>);
        return ResponseUpdatePassword.fromJson(response.data);
    }

    Future<ResponseAuthentication> auth(RequestAuth requestAuth) async {
        Response response = await (postHttp(Endpoints.login(), data: requestAuth) as FutureOr<Response<dynamic>>);
        return ResponseAuthentication.fromJson(response.data);
    }


    Future<ResponseAuthentication> refresh(RequestRefresh requestRefresh) async {
        Response response = await (postHttp(Endpoints.refresh(), data: requestRefresh) as FutureOr<Response<dynamic>>);
        return ResponseAuthentication.fromJson(response.data);
    }

    Future<ResponseAuthentication> deposit() async {
        Response response = await (getHttp(Endpoints.deposit()) as FutureOr<Response<dynamic>>);
        return ResponseAuthentication.fromJson(response.data);
    }

}