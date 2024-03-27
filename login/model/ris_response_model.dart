import 'login_response_model.dart';

class RisResponseModel {
  String? prediction;
  //String? explanation;

  RisResponseModel({this.prediction});

  RisResponseModel.fromJson(Map<String, dynamic> json) {
    prediction = json['prediction'];
    //explanation = json['explanation'];
  }
  getRisResponseModel(){
    return this.prediction;
  }
}