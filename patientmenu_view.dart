import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/patientmenu_view_model.dart';
import 'package:auth_manager/riskdetails_view.dart';
import 'package:auth_manager/riskmenu_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'armsleeve_webview.dart';
import 'login/home_view_model.dart';
import 'login/login_view.dart';
import 'login/searchpatient_view.dart';
import 'dart:js' as js;
class PatientMenuView extends StatefulWidget with PatientManager{
  const PatientMenuView({Key? key}) : super(key: key);

  @override
  _PatientMenuViewState createState() => _PatientMenuViewState();
}

class _PatientMenuViewState extends State<PatientMenuView> {
  AuthenticationManager _authManager = Get.find();
  // PatientManager _patientManager =Get.put(PatientManager());
  PatientMenuViewModel _viewModel = Get.put(PatientMenuViewModel());
  String patientIDD="false";
  @override
  Widget build(BuildContext context) {
    if(_viewModel.getPatientIDD() !=null){
      patientIDD=_viewModel.getPatientIDD()!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('PatientMenu'),
        actions: [
          IconButton(
            onPressed: () async {
              await _viewModel.logoutUser();
              _authManager.logOut();
              Get.offAll(LoginView());
            },
            icon: Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PatientID:"+patientIDD),
            ElevatedButton(
              onPressed: () {
                //TODO: Check again based on searchpatient_view_model
                if(_authManager.checkLoginStatus2()){
                  Get.to(RiskMenuView());
                }
                else{
                  Get.off(LoginView());
                }
              },
              child: Text('Risk Assessment'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Is logged in");
                }
                else{
                  Get.off(LoginView());
                }
              },
              child: Text('Update patient profile'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Is logged in");
                }
                else{
                  Get.off(LoginView());
                }
              },
              child: Text('History'),
            ),
          ],
        ),
      ),
    );
  }
}

