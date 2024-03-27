import 'dart:html';

import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
  }

  Future<void> loginUser(String email, String password) async {
    final response = await _loginService
        .fetchLogin(LoginRequestModel(email: email, password: password))
    .catchError((error)=>print('Problem connecting to server $error'));

    if (response != null) {
      _authManager.login(response.token);
      //print("authmanager");
      print(response);
      print(response.token);
      print("login response is not null");
    } else {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Server is down or given (username, password) combination is wrong',
          icon: const Icon(Icons.dangerous),
          duration: const Duration(seconds: 3),
        ),
      );

    }
  }

  Future<void> registerUser(String email, String password) async {
    final response = await _loginService
        .fetchRegister(RegisterRequestModel(email: email, password: password));

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.token);
    } else {
      /// Show user a dialog about the error response
      Get.showSnackbar(
        GetSnackBar(
          message: 'Wrong username or password',
          icon: const Icon(Icons.dangerous),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
