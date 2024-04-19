import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/login/login_view_model.dart';
import 'package:auth_manager/login/searchpatient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../core/authentication_manager.dart';
import '../core/cache_manager.dart';
import '../patientmenu_view.dart';
import 'login_view.dart';

class SearchPatientView extends StatefulWidget with PatientManager{
   //final CacheManager _cacheManager;
  const SearchPatientView({Key? key}) : super(key: key);

  @override
  _SearchPatientView createState() => _SearchPatientView();
}

class _SearchPatientView extends State<SearchPatientView> {
  AuthenticationManager _authManager = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  SearchPatientViewModel _viewModel = Get.put(SearchPatientViewModel());
  TextEditingController patientIDctr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Search Patient'),
      //),
      actions:[
        IconButton(
        onPressed: () async {
          await _viewModel.logoutUser();
          _authManager.logOut();
          Get.offAll(LoginView());
        },
        icon: Icon(Icons.logout_rounded),
      )]),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event.runtimeType == RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              _onButtonPressed();
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: searchpatientForm(),
        ),
      ),
    );
  }

  Form searchpatientForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: patientIDctr,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter PatientID'
                : null;
          },
        ),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
          onPressed: _onButtonPressed,
          child: Text('Search Patient'),
        ),
      ]),
    );
  }

  void _onButtonPressed() async {
    if (formKey.currentState?.validate() ?? false) {
      await _viewModel.searchPatient(patientIDctr.text);
      if(_viewModel.foundPatient()){
        if(_authManager.checkLoginStatus2()){
          Get.to(PatientMenuView());
        }
        else{
          Get.off(LoginView());
        }
      }//if patient not found, check whether user should be prompted to log-in screen or retry with another patientID
      else{
        if(_authManager.checkLoginStatus2()){
          Get.showSnackbar(
            GetSnackBar(
              message: 'PatientID not found',
              icon: const Icon(Icons.dangerous),
              duration: const Duration(seconds: 3),
            ),
          );
        }else{
          Get.offAll(LoginView());
        }
      }
    }
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.grey),
    fillColor: Colors.grey.shade200,
    filled: true,
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    prefixIconConstraints: BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
  );
}
enum FormType { searchpatient }
