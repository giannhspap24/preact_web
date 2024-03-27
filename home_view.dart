import 'package:auth_manager/core/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'armsleeve_webview.dart';
import 'login/home_view_model.dart';
import 'login/login_view.dart';
import 'login/searchpatient_view.dart';
import 'dart:js' as js;
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthenticationManager _authManager = Get.find();
  HomeViewModel _viewModel = Get.put(HomeViewModel());

  Future<void> initializeSettings() async {
    //if user is not logged in, move him to login screen
    if (_authManager.checkLoginStatus2()) {
      print("Currently user is logged in");
    }else{
      print(_authManager.checkLoginStatus2());
      Get.off(LoginView());
      print("you should be moved to login screen ");
    }
    //Simulate other services for 1 seconds
    await Future.delayed(Duration(seconds: 1));
  }
  @override
  Widget build(BuildContext context) {
    print("Built home view");
    initializeSettings();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
            ElevatedButton(
              onPressed: () {
                //GET.TO FOR THE screens we want to go back
                //otherwise use get.off(view())
                Get.to(SearchPatientView());
              },
              child: Text('Patients'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                 // initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('Treatment info'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                  //initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('General information'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                  //initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('Practical info'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                 // initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('Shared Experience'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                //  initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('Source referencing'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                 // initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('Arm Sleeve'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_authManager.checkLoginStatus2()){
                  print("Press");
                  //initializeSettings();
                }else{
                  Get.off(LoginView());
                }
              },
              child: Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}

