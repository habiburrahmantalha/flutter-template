import 'package:dio/dio.dart';
import 'package:flutter_template/network/endpoints.dart';
import 'package:flutter_template/network/models/request.dart';
import 'package:flutter_template/network/models/response.dart';
import 'package:flutter_template/utils/dio.dart';


class AuthApi {
    Future<ResponseRegister> register(RequestRegister requestRegister) async {
        Response response = await postHttp(Endpoints.register(), data: requestRegister);
        return ResponseRegister.fromJson(response.data);
    }

    Future<ResponseLogin> login(RequestLogin requestLogin) async {
        Response response = await postHttp(Endpoints.login(), data: requestLogin);
        return ResponseLogin.fromJson(response.data);
    }

    Future<ResponseUpdatePassword> updatePassword(RequestUpdatePassword updatePassword) async {
        Response response = await postHttp(Endpoints.changePassword(), data: updatePassword);
        return ResponseUpdatePassword.fromJson(response.data);
    }


}