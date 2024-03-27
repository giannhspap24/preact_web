class LogoutRequestModel {
  String? authtoken;
  //String? username;
  LogoutRequestModel({this.authtoken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action']='logout_request';
    //data['username'] = this.username;
    data['authtoken'] = this.authtoken;
    return data;
  }
}