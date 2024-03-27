import 'dart:html';

import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'model/logout_request_model.dart';

class LogoutModel extends GetxController with CacheManager {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
  }

  // Future<void> loginUser(String email, String password) async {
  //   final response = await _loginService
  //       .fetchAlbum();
  //   if (response != null) {
  //     print('logged in');
  //   }else{
  //     print('not logged');
  //   }
  // }

  Future<void> logoutUser(String authtoken) async {
    final response = await _loginService
        .fetchLogout(LogoutRequestModel(authtoken: authtoken));

    if (response != null) {
      /// Set isLogin to false
      _authManager.logOut();
      //print("authmanager");
      print(response);
      print(response.token);
    } else {
      /// Show user a dialog about the error response
      print("is null");
      print(response);
      //print(response.token);
      // Get.defaultDialog(
      //     middleText: 'User not found!',
      //     textConfirm: 'OK',
      //     confirmTextColor: Colors.white,
      //     onConfirm: () {
      //       Get.back();
      //     });
      //Text('Wrong username or password');
      // Get.showSnackbar(
      //   GetSnackBar(
      //     message: 'Wrong username or password',
      //     icon: const Icon(Icons.dangerous),
      //     duration: const Duration(seconds: 3),
      //   ),
      // );
      //controller: passwordCtr,
      //decoration: inputDecoration('Password', Icons.lock),
    }
    //here needs modificaiton
  }
}
