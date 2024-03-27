import 'package:auth_manager/core/patient_manager_obs.dart';
import 'package:auth_manager/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/authentication_manager.dart';
import '../home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  LoginViewModel _viewModel = Get.put(LoginViewModel());
  AuthenticationManager _authManager = Get.find();
  //PatientManagerObs _patientManager = Get.find();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _formType == FormType.login ? Text('Login') : Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _formType == FormType.login ? loginForm() : registerForm(),
      ),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: emailCtr,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Username'
                : null;
          },
          decoration: inputDecoration('Username', Icons.person),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Password'
                : null;
          },
          controller: passwordCtr,
          obscureText: true, //show character '*' per letter
          decoration: inputDecoration('Password', Icons.lock),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              await _viewModel.loginUser(emailCtr.text, passwordCtr.text);
              if (_authManager.checkLoginStatus2()) {
                Get.off(HomeView());
              }else{
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'Server is not available',
                    icon: const Icon(Icons.dangerous),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            }else{
              print("User is logged out");
            }
          },
          child: Text('Login'),
        ),
      ]),
    );
  }

  Form registerForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: emailCtr,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Email'
                : null;
          },
          decoration: inputDecoration('E-mail', Icons.person),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Password'
                : null;
          },
          controller: passwordCtr,
          decoration: inputDecoration('Password', Icons.lock),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty || value != passwordCtr.text)
                ? 'Passwords does not match'
                : null;
          },
          decoration: inputDecoration('Retype Password', Icons.lock),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              await _viewModel.registerUser(emailCtr.text, passwordCtr.text);
            }
          },
          child: Text('Register'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _formType = FormType.login;
            });
          },
          child: Text('Login'),
        )
      ]),
    );
  }
}
//https://www.aueb.gr/sites/default/files/Winter-Exams-23-24%2020231205.pdf
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

enum FormType { login, register }
