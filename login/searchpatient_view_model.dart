import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'model/logout_request_model.dart';
import 'model/patient_request_model.dart';
import 'model/ris_request_model.dart';

class SearchPatientViewModel extends GetxController with CacheManager,PatientManager{
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
  }
  //Log out user from search_patient screen
  Future<void> logoutUser() async {
    print("Trying to logout through search_patient_view_model");
    final response = await _loginService.fetchLogout(LogoutRequestModel(authtoken: getToken()));
    if (response != null) {
      print(response.token);
      _authManager.logOut();
      print("Logged out user through search_patient_view_model: logout received");
    } else {
      print("Logout user through search_patient_view_model: null response received");
    }
  }

  Future<void> searchPatient(String patientID) async {
    final response = await _loginService.fetchsearchPatientRequest(PatientRequestModel(patientID: patientID,token: getToken()));
    if (response != null) {
      print("Searchpatient_view_model: response is not null");
      String? jsonString=response.name;
        if(jsonString?.contains("logout")==null || jsonString?.contains("logout")==true){
        print("User should be logged out from searchpatient_view_model");
        _authManager.logOut();
      }else{
        await savePatientID(patientID);
        print("PatientID saved in PatientManager");
      }
    } else {
      await savePatientID(null);
    }
  }

  //Check if patientID found or not
  bool foundPatient()  {
    if(getPatientID()!=null){
      return true;
    }else{
      return false;
    }
  }

}
