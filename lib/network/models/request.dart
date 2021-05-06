class RequestRegister {
  String? fullName;
  String? email;
  String? password;

  RequestRegister({this.fullName, this.email, this.password});

  RequestRegister.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class RequestLogin {
  String? email;
  String? password;

  RequestLogin({this.email, this.password});

  RequestLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class RequestUpdatePassword {
  String? currentPassword;
  String? newPassword;
  String? newConfirmPassword;

  RequestUpdatePassword(
      {this.currentPassword, this.newPassword, this.newConfirmPassword});

  RequestUpdatePassword.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    newConfirmPassword = json['new_confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_password'] = this.currentPassword;
    data['new_password'] = this.newPassword;
    data['new_confirm_password'] = this.newConfirmPassword;
    return data;
  }
}

