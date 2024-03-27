import 'package:auth_manager/core/cache_manager.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import '../login/model/logout_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';

class AuthenticationManager extends GetxController with CacheManager {

  final searchedPatient=false.obs; //observable: if user tried to search or not for a patientID
  final isLogged = false.obs; //observable: if user is logged in or not

  //Update searchedPatient to false and delete token
  void searchPatient() async{
    searchedPatient.value=true;
  }

  //Update isLogged to false and delete token
  void logOut() {
    isLogged.value = false;
    removeToken();
    print("Authentication manager: logout is called and token is removed");
  }

  //Update isLogged to true with token
  void login(String? token) async {
    isLogged.value = true;
    print("Authentication manager: login is called with token"+token!);
    //Token is cached
    await saveToken(token);
  }

  //Update isLogged to true without token
  void login2() async {
    isLogged.value = true;
    //Token is cached
  }

  //Check/Update current login status
  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      print("the token is"+token!);
      print(token.toString()=="logout");
      isLogged.value = true;
   }
  }

  //Return current login status
  bool checkLoginStatus2() {
    final token = getToken();
    if (token != null) {
      print("the token is"+token!);
      print(token.toString()=="logout");
    }
  return isLogged.value;
  }

  //Return global URL
  String getGlobalURl(){
    //final String globalUrl = 'http://localhost:8080/preact/HelloServlet';
    //final String globalUrl = 'http://192.168.56.101:8080/preact/HelloServlet';
    //final String globalUrl = 'http://195.251.234.22:8080/preact/HelloServlet';
    return 'http://localhost:8080/preact/HelloServlet';
  }
}
