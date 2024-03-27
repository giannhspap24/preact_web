import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/login_response_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/model/register_response_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/authentication_manager.dart';
import '../model/logout_request_model.dart';
import '../model/logout_response_model.dart';
import '../model/patient_request_model.dart';
import '../model/patient_response_model.dart';
import '../model/ris_request_model.dart';
import '../model/ris_response_model.dart';

//import '../model/example.dart';
class LoginService extends GetConnect {
  late final String globalUrl = 'http://localhost:8080/preact/HelloServlet';
  //final String globalUrl = 'http://192.168.56.101:8080/preact';
  //final String globalUrl = 'http://195.251.234.22:8080/preact/HelloServlet';

//Login by sending request to server and receiving response a token
  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    print('Trying to Log in');
    final  response = await http.post(Uri.parse(globalUrl),body: jsonEncode(model.toJson()));
    print(response.statusCode);
    //402: Username and password match, successful login
    if (response.statusCode == HttpStatus.ok) {
      print('Connected to server and logged in');
      print(response.body);
      String jsonString=response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
    return LoginResponseModel.fromJson(jsonMap);
    } //401: Username and password do not match
    else if (response.statusCode == 401){
      print('User wrong credentials');
      return null;
    }//403: User is already logged in
    else if (response.statusCode == 403){
      print('User is already logged in');
      return null;
    }//408: Cannot reach server
    else{
      print('Cannot connect to server');
      return null;
    }
  }

//Logout by sending request to server and receiving response a token "logout"
  Future<LogoutResponseModel?> fetchLogout(LogoutRequestModel model) async {
    print('Trying to log-out');
    final response = await http.post(Uri.parse(globalUrl),body: jsonEncode(model.toJson()));
    print("Sent logout request");
    //402: Successfully logged out
    if (response.statusCode == HttpStatus.ok) {
      print('User successfully logged out');
      String jsonString=response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return LogoutResponseModel.fromJson(jsonMap);
    } //403: User is already logged out
    else if (response.statusCode == 403){
      print('Server responded that is already logged out');
      return null;
    }//408: Time-out, token expired
    else{
      print('Cannot connect to server');
      return null;
    }
  }
//Fetch patient info  by sending request to server. If logged out, response is a token "logout"
  Future<PatientResponseModel?> fetchsearchPatientRequest(PatientRequestModel model) async {
    print('Trying to request patient info to server');
    final response = await http.post(Uri.parse(globalUrl),body: jsonEncode(model.toJson()));
    print(response.statusCode);
    //402: Patient Found
    if (response.statusCode == HttpStatus.ok) {
      print('Found patient');
      String jsonString=response.body;
      Map<String,dynamic> jsonMap = json.decode(jsonString);
      return PatientResponseModel.fromJson(jsonMap);
    } //401: Patient not Found
    else if (response.statusCode == 401){
      print('Not such patient');
      return null;
    } //408: Time-out, token expired
    else{
      print('Session expired during search patient request');
      String jsonString=response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return PatientResponseModel.fromJson(jsonMap); //Patient.name = "logout" --dummy
    }
  }
//Fetch patient risk prediction  by sending request to server. If logged out, response is a token "logout"
  Future<RisResponseModel?> fetchsearchRequest(RisRequestModel model) async {
    print('Trying to request risk prediction to server');
    final response = await http.post(Uri.parse(globalUrl),body: jsonEncode(model.toJson()));
    print(response.statusCode);
    //402: Risk prediction class and explanation received
    if (response.statusCode == HttpStatus.ok) {
      print('Found patient and got his/her prediction');
      String jsonString=response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return RisResponseModel.fromJson(jsonMap);
      //401: Could not retrieve patient risk
    } else if (response.statusCode == 401){
      print('Could not retrieve patient risk');
      return null;
    }else //408: Time-out, token expired
    {
      print('Session expired during get risk prediction request');
      String jsonString=response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return RisResponseModel.fromJson(jsonMap); //Riskprediction.prediction = "logout" --dummy
    }
  }
 //Fetch risk report pdf by sending request to server. If logged out, response is a token "logout"
  Future<void> fetchriskreportRequest(RisRequestModel model) async {
    print('Trying to request risk report to server');
    final response = await http.post(Uri.parse(globalUrl),body: jsonEncode(model.toJson()));

    if (response.statusCode == HttpStatus.ok) {
       print("Received risk report.pdf succesfully");
    }else if (response.statusCode == 401){
      print("Requested but did not get pdf");
      return null;
    }else{
      print('Session expired during get risk report request');
      return null;
     }
  }

  //Not used yet- under construction
  Future<RegisterResponseModel?> fetchRegister(RegisterRequestModel model) async {
    print('tried to register');
      final response = await http
             .get(Uri.parse(globalUrl));

    if (response.statusCode == HttpStatus.ok) {
      return RegisterResponseModel.fromJson(response.body as Map<String, dynamic>);
    } else {
      return null;
    }
  }

}
