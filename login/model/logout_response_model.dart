class LogoutResponseModel {
  String? token;

  LogoutResponseModel({this.token});

  LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
  getLogoutResponseModel(){
    return this.token;
  }
}