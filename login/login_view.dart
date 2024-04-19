import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../core/authentication_manager.dart';
import '../home_view.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  LoginViewModel _viewModel = Get.put(LoginViewModel());
  AuthenticationManager _authManager = Get.find();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFcde3f8),
        appBar: AppBar(
          flexibleSpace: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/preactlogo.jpg'), // Replace 'images/preactlogo_new.jpg' with your image path
                fit: BoxFit.contain, // Adjust the image fit
              ),
            ),
          ),
          toolbarHeight: 50, // Adjust the toolbar height as per your requirement
        ),
      body:
      Center(
      child:Container(
        width: 400, // Set your desired width here
        child: RawKeyboardListener(
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
            child: _formType == FormType.login ? loginForm() : registerForm(),
          ),
        ),
      ),
      )
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: 28,
            color: Colors.indigo,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 8,
          width: 12,
        ),
        TextFormField(
          controller: emailCtr,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? '' //Please enter Username
                : null;
          },
          decoration: inputDecoration('E-mail', Icons.email ),

        ),
        SizedBox(
          height: 8,
          width: 12,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? ''  //Please enter Password
                : null;
          },
          controller: passwordCtr,
          obscureText: true,
          decoration: inputDecoration('Password', Icons.lock),
        ),
        SizedBox(
          height: 10, // Add desired space between TextFormField and ElevatedButton
        ),
        ElevatedButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo, // Change button color to blue
            //onPrimary: Colors.white, // Change text color to white
          ),
          child: SizedBox(
            child: Center(
              child: Text('Log in',style: TextStyle(color: Colors.white,fontSize: 18), ),
            ),
          ),
        ),
        SizedBox(
          height: 10, // Add desired space between TextFormField and ElevatedButton
        ),
        Text(
          'Forgot Password?',
          style: TextStyle(
              fontSize: 14,
              color: Colors.indigo,
          ),
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
          onPressed: _onButtonPressed,
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

  void _onButtonPressed() async {
    if (formKey.currentState?.validate() ?? false) {
      if (_formType == FormType.login) {
        await _viewModel.loginUser(emailCtr.text, passwordCtr.text);
      } else {
        await _viewModel.registerUser(emailCtr.text, passwordCtr.text);
      }
      if (_authManager.checkLoginStatus2()) {
        Get.off(HomeView());
      } else {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Authentication error: either (username, password) combination is not correct or user is already logged in', //'Server is not available'
            icon: const Icon(Icons.dangerous),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      print("User is logged out");
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

enum FormType { login, register }
