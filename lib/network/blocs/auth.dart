import 'dart:convert';

import 'package:flutter_template/network/api/auth.dart';
import 'package:flutter_template/network/blocs/loading.dart';
import 'package:flutter_template/network/models/data.dart';
import 'package:flutter_template/network/models/request.dart';
import 'package:flutter_template/network/models/response.dart';
import 'package:flutter_template/utils/dio.dart';
import 'package:flutter_template/utils/sharedpreference.dart';
import 'package:flutter_template/values/constants.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc{

    final _api = AuthApi();
    final Map<String, dynamic> _values = {};

    final PublishSubject _subjectRegister = PublishSubject<ResponseRegister>();
    PublishSubject<ResponseRegister> get subjectRegister => _subjectRegister as PublishSubject<ResponseRegister>;

    final PublishSubject _subjectLogin = PublishSubject<ResponseLogin>();
    PublishSubject<ResponseLogin> get subjectLogin => _subjectLogin as PublishSubject<ResponseLogin>;

    final PublishSubject _subjectUpdatePassword = PublishSubject<ResponseUpdatePassword>();
    PublishSubject<ResponseUpdatePassword> get subjectUpdatePassword => _subjectUpdatePassword as PublishSubject<ResponseUpdatePassword>;

    final BehaviorSubject _subjectUser = BehaviorSubject<User?>();
    BehaviorSubject<User?> get subjectUser => _subjectUser as BehaviorSubject<User?>;

    final BehaviorSubject _subjectAuth = BehaviorSubject<ResponseAuthentication>();
    BehaviorSubject<ResponseAuthentication?> get subjectAuth => _subjectAuth as BehaviorSubject<ResponseAuthentication>;

    setValue(key, value){
        _values[key] = value;
    }

    register() async {
        loadingBloc.start(LoadingType.register);
        _api.register(RequestRegister(fullName: _values['fullName'], email: _values['email'],password: _values['password'])).then((value) {
            _subjectRegister.sink.add(value);
            _subjectUser.sink.add(value.user);
            DioSingleton.instance.update(value.token);
            saveUserAndToken(value.token!, value.user!);
            loadingBloc.end(LoadingType.register);
        }).catchError((error) {
            // if (error.response != null) {
            //     ResponseAuthenticate response = ResponseAuthenticate.fromJson(
            //         json.decode(error.response.toString()));
            //     throw HttpException(response.message);
            // } else {
            //     throw HttpException("Unknown Error, Please try again");
            // }
            loadingBloc.end(LoadingType.register);
        });

    }

    login() async {
        loadingBloc.start(LoadingType.login);
        _api.login(RequestLogin(email: _values['email'],password: _values['password'])).then((value) {
            _subjectLogin.sink.add(value);
            _subjectUser.sink.add(value.user);
            DioSingleton.instance.update(value.token);
            saveUserAndToken(value.token!, value.user!);
            loadingBloc.end(LoadingType.login);
        }).catchError((error) {
            // if (error.response != null) {
            //     ResponseAuthenticate response = ResponseAuthenticate.fromJson(
            //         json.decode(error.response.toString()));
            //     throw HttpException(response.message);
            // } else {
            //     throw HttpException("Unknown Error, Please try again");
            // }
            loadingBloc.end(LoadingType.login);
        });

    }

    dispose(){
        _subjectLogin.close();
        _subjectRegister.close();
        _subjectUser.close();
        _subjectUpdatePassword.close();
        _subjectAuth.close();
    }

  void saveUserAndToken(String token, User user) {
        SharedPreferenceManager.instance.setString(Constant.user, json.encode(user.toJson()));
        SharedPreferenceManager.instance.setString(Constant.token, token);
  }

  isLoggedIn(){
        SharedPreferenceManager.instance.getString(Constant.token).then((value) {
            if(value.isNotEmpty){
                DioSingleton.instance.update(value);
                print(value);
                SharedPreferenceManager.instance.getString(Constant.user).then((userString) {
                    print(userString);
                    if(userString.isNotEmpty){
                        try {
                            User user = User.fromJson(json.decode(userString));

                            _subjectUser.sink.add(user);
                        }catch(e){
                            print("###User not found###");
                        }
                    }else{
                        print("###User not found###");
                    }
                });
            }else{
                print("###Token not found###");
            }
        });
  }

  void updatePassword() {
      loadingBloc.start(LoadingType.updatePassword);
      _api.updatePassword(RequestUpdatePassword(currentPassword: _values['current_password'],newPassword: _values['new_password'], newConfirmPassword: _values['new_confirm_password'])).then((value) {
          _subjectUpdatePassword.sink.add(value);
          loadingBloc.end(LoadingType.updatePassword);
      }).catchError((error) {
          loadingBloc.end(LoadingType.updatePassword);
      });
  }

  void auth() {
      loadingBloc.start(LoadingType.login);
      _api.auth(RequestAuth(username: "suryanarayana@flyhub.com",password: "test@12345")).then((value) {
          _subjectAuth.sink.add(value);
          loadingBloc.end(LoadingType.login);
      }).catchError((error) {
          print("LOGIN ERROR");
          print(error);
          loadingBloc.end(LoadingType.login);
      });
  }

    void refresh() {

        ResponseAuthentication response = _subjectAuth.value;
        loadingBloc.start(LoadingType.login);
        _api.refresh(RequestRefresh(token: response.token,refreshToken: response.refreshToken)).then((value) {
            _subjectAuth.sink.add(value);
            loadingBloc.end(LoadingType.login);
            DioSingleton.instance.update(value.token);
        }).catchError((error) {
            print("LOGIN REFRESH");
            print(error);
            loadingBloc.end(LoadingType.login);
        });
    }

    void deposit() {


        loadingBloc.start(LoadingType.login);
        _api.deposit().then((value) {

            loadingBloc.end(LoadingType.login);
        }).catchError((error) {
            print("LOGIN Deposit");
            print(error);
            loadingBloc.end(LoadingType.login);
        });
    }
}

final authBloc = AuthBloc();