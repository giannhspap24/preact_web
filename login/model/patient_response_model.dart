import 'login_response_model.dart';

class PatientResponseModel {
  String? name;
  PatientResponseModel({this.name});

  PatientResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];

  }

  String? getPatientResponseModel(){
    return this.name;
  }
}