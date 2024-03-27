import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'login/model/logout_request_model.dart';

class PatientMenuViewModel extends GetxController with PatientManager,CacheManager{
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;
  //late final PatientManager _patientManager;
  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
    //_patientManager=Get.find();
  }
  String? getPatientIDD(){
      return getPatientID();
  }

  String? getPatientName(){
    return getPatientID();
  }

  Future<void> logoutUser() async {
    print("Trying to logout through patient_view_model");
    final response = await _loginService.fetchLogout(LogoutRequestModel(authtoken: getToken()));

    if (response != null) {
      print(response.token);
      _authManager.logOut();
      print("Logged out user through patientmenu_view_model: logout received");
    } else {
      print("Logout user through patientmenu_view_model: null response received");
    }

  }

}
