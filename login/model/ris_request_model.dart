import 'login_response_model.dart';

class RisRequestModel {
  String? patientID;
  String? token;
  String? requesttype;
  RisRequestModel({this.patientID,this.token,this.requesttype});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['action']='ris_request';
    data['action']=requesttype;
    data['authtoken']=token;
    //data['auth_token'] = LoginResponseModel();
    data['patientid'] = this.patientID;
    return data;
  }

}