import 'login_response_model.dart';

class RisReportRequestModel {
  String? patientID;
  String? token;
  RisReportRequestModel({this.patientID,this.token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action']='risreport_request';
    data['authtoken']=token;
    //data['auth_token'] = LoginResponseModel();
    data['patientid'] = this.patientID;
    return data;
  }

}