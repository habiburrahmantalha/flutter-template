import 'package:flutter_template/network/models/data.dart';

class ResponseRegister {
  bool error;
  String message;
  User user;
  String token;

  ResponseRegister({this.error, this.message, this.user, this.token});

  ResponseRegister.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class ResponseLogin {
  bool error;
  User user;
  String token;

  ResponseLogin({this.error, this.user, this.token});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class ResponseHealth {
  String status;
  bool redis;
  bool db;
  String timestamp;

  ResponseHealth({this.status, this.redis, this.db, this.timestamp});

  ResponseHealth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    redis = json['redis'];
    db = json['db'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['redis'] = this.redis;
    data['db'] = this.db;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class ResponseUpdatePassword {
  bool error;
  String message;
  User data;

  ResponseUpdatePassword({this.error, this.message, this.data});

  ResponseUpdatePassword.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}














