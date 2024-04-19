import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/explanations_view.dart';
import 'package:auth_manager/patientmenu_view_model.dart';
import 'package:auth_manager/riskdetails_view.dart';
import 'package:auth_manager/riskmenu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'armsleeve_webview.dart';
import 'core/patient_manager_obs.dart';
import 'login/home_view_model.dart';
import 'login/login_view.dart';
import 'login/searchpatient_view.dart';
import 'dart:js' as js;
class RiskMenuView extends StatefulWidget with PatientManager{
  const RiskMenuView({Key? key}) : super(key: key);

  @override
  _RiskMenuViewState createState() => _RiskMenuViewState();
}

class _RiskMenuViewState extends State<RiskMenuView> {
  AuthenticationManager _authManager = Get.find();
  PatientManagerObs _patientManager =Get.put(PatientManagerObs());
  RiskMenuViewModel _viewModel = Get.put(RiskMenuViewModel());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('RiskMainMenu'),
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
            Obx(() {
              return Text("PatientID:"+_viewModel.patientIDD.value);
            }),
            //Text("PatientID:"+ _patientManager.getPatientID()),
            ElevatedButton(
              onPressed: () async {
                if(_authManager.checkLoginStatus2()){
                  Get.to(RiskDetailsView()); //
                }
                else{
                  Get.off(LoginView());
                }
              },
              child: Text('Risk Assessment'),
            ),
            ElevatedButton(
              onPressed: () async {
                if(_authManager.checkLoginStatus2()){
                  Get.to(ExplanationsView()); //
                }
                else{
                  Get.off(LoginView());
                }
              },
              child: Text('Explanations'),
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
              child: Text('TempExplanations'),
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
              child: Text('Arm sleeve'),
            ),ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Is logged in");
                }
                else{
                  Get.off(LoginView());
                }
              },
              child: Text('References'),
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
              child: Text('Recommendations to minnimize risk'),
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
              child: Text('Other side effects'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Is logged in");
                }
                else{
                  Get.offAll(LoginView());
                }
              },
              // onPressed: () {
              //   _viewModel.getRiskReport(patientIDD);
              // },
              child: Text('General report (PDF)'),
            ),
          ],
        ),
      ),
    );
  }
}

