class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action']='login_request';
    data['username'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
