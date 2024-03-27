import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/core/prediction_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:auth_manager/riskdetails_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'login/model/logout_request_model.dart';
import 'login/model/ris_request_model.dart';
import 'login/model/risreport_request_model.dart';

class RiskDetailsViewModel extends GetxController with CacheManager,PatientManager,PredictionManager{
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;
  //late final PatientManager _patientManager;
  var riskprediction="".obs; //make this observable

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
    //_patientManager=Get.find();
    //RiskDetailsView=widget.RiskDetailsView;
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) { asyncGetRiskPrediction("1616"); });
  }

  asyncGetRiskPrediction(String patientID) async {
    final response = await _loginService
        .fetchsearchRequest(RisRequestModel(patientID: patientID,token: getToken(),requesttype: 'ris_request'));

    if (response != null) {
      print("riskdetails_view_model: response is not null");
      String? jsonString=response.prediction;

      if(jsonString?.contains("logout")==null || jsonString?.contains("logout")==true){
        print("User should be logged out from riskdetails_view_model");
        _authManager.logOut();
      }else{
        savePredictionClass(jsonString);
        print("Prediction saved in PredictionManager");
      }
    } else {
      savePredictionClass("Risk prediction is not available");
    }
  }
  //Log out user from riskdetails screen
  Future<void> logoutUser() async {
    print("Trying to logout through riskdetails_view_model");
    final response = await _loginService.fetchLogout(LogoutRequestModel(authtoken: getToken()));
    if (response != null) {
      print(response.token);
      _authManager.logOut();
      print("Logged out user through riskdetails_view_model: logout received");
    } else {
      print("Logout user through riskdetails_view_model: null response received");
    }
  }

  //Get risk prediction from server with patientID
  //TODO: here we need the observable prediction
  Future<void> getRiskPrediction(String patientID) async {
    final response = await _loginService
        .fetchsearchRequest(RisRequestModel(patientID: patientID,token: getToken(),requesttype: 'ris_request'));

    if (response != null) {
      print("riskdetails_view_model: response is not null");
      String? jsonString=response.prediction;

      if(jsonString?.contains("logout")==null || jsonString?.contains("logout")==true){
        print("User should be logged out from riskdetails_view_model");
        _authManager.logOut();
      }else{
        savePredictionClass(jsonString);
        print("Prediction saved in PredictionManager");
      }
    } else {
      savePredictionClass("Risk prediction is not available");
    }
    // if (response != null) {
    //
    //   print("is not null");
    //   riskprediction=response.getRisResponseModel();
    //   print(riskprediction);
    //   savePredictionClass(riskprediction);
    // } else { //did not receive answer so token expired
    //   savePredictionClass("Risk prediction is not available");
    // }

  }

  Future<void> getRiskReport(String patientID) async {
    final response = await _loginService
        .fetchriskreportRequest(RisRequestModel(patientID: patientID,token: getToken(),requesttype: 'risreport_request'));

    // if (response != null) {
    //
    //   //_authManager.login(response.token);
    //   print("is not null");
    //
    //   //riskprediction=response.getRisResponseModel();
    //   //print(riskprediction);
    //   //savePredictionClass(riskprediction);
    //   //riskprediction=getRisResponseModel();
    //   //print(response.token);
    // } else { //did not receive answer so token expired
    //   savePredictionClass("Risk prediction is not available");
   // }
  }

  String? getPrediction(){ //from PredictionManager
    print(riskprediction);
    return getPredictionClass();
  }
  String? getPatientIDD(){ //from PatientManager
    return getPatientID();

  }
  String? getPatientName(){
    return getPatientID();

  }
}
