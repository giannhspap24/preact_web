import 'dart:core';
import 'dart:core';

import 'package:auth_manager/core/cache_manager.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import '../login/model/logout_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';

class PatientManagerObs extends GetxController with CacheManager {

   final patientID="".obs; //observable: if user tried to search or not for a patientID
   final patientName = "".obs; //observable: if user is logged in or not

  //Update searchedPatient to false and delete token
  void setPatientID(String? patientIDD) async {
    //print("Retrieved patientID from Cache: PatientManager obs");
    patientID.value=patientIDD!;
  }

  String getPatientID(){
    return patientID.value;
  }

   //Update searchedPatient to false and delete token
   void setPatientName(String? patientname) async {
     //print("Retrieved patientID from Cache: PatientManager obs");
     patientName.value=patientname!;
   }

   String getPatientName(){
     return patientName.value;
   }

}
