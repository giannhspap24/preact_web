import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/patient_manager_obs.dart';
import 'core/prediction_manager.dart';
import 'login/model/logout_request_model.dart';
import 'login/model/ris_request_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RiskMenuViewModel extends GetxController with CacheManager,PatientManager,PredictionManager{
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;
  late final PatientManagerObs _patientManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
    _patientManager=Get.find();
  }

  //Get patientID from PatientManager
  String? getPatientIDD(){
    return getPatientID();

  }
  //Get patient name from PatientManager
  String? getPatientName(){
    return getPatientID();
  }

  //Log out user from risk menu screen
  Future<void> logoutUser() async {
    print("Trying to logout through riskmenu_view_model");
    final response = await _loginService.fetchLogout(LogoutRequestModel(authtoken: getToken()));
    if (response != null) {
      print(response.token);
      _authManager.logOut();
      print("Logged out user through riskmenu_view_model: logout received");
    } else {
      print("Logout user through riskmenu_view_model: null response received");
    }
  }
  //Get risk prediction from server for specific patientID
  Future<void> getRiskPrediction(String patientID) async {
    final response = await _loginService.fetchsearchRequest(RisRequestModel(patientID: patientID,token: getToken(),requesttype: 'ris_request'));

    String? jsonString=response?.prediction;

    if (response != null) {
      print("Riskmenu_view_model: response is not null");
      if (jsonString?.contains("logout") == null || jsonString?.contains("logout") == true) {
        print("User should be logged out from Riskmenu_view_model");
        _authManager.logOut();
      } else {
        _patientManager.setPatientID(patientID);
        _patientManager.setPatientName(jsonString);
        print("Received risk prediction successfully");
      }
    }else{
      print("Requested but did not received risk prediction");
    }
  }

  //TODO: Under construction for pdf report
  Future<void> getRiskReport(String patientID) async {
    final response = await _loginService
        .fetchriskreportRequest(RisRequestModel(patientID: patientID,token: getToken(),requesttype: 'risreport_request'));
    // if (response != null) {
    //
    // }else{
    //
    // }
  }

}
