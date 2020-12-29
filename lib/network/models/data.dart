class User {
  String id;
  String fullName;
  String email;
  String createdAt;

  User({this.id, this.fullName, this.email, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    return data;
  }
}
