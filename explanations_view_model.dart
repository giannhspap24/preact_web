import 'dart:convert';

import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/login/model/login_request_model.dart';
import 'package:auth_manager/login/model/register_request_model.dart';
import 'package:auth_manager/login/model/risexplanations_request_model.dart';
import 'package:auth_manager/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'core/patient_manager_obs.dart';
import 'core/prediction_manager.dart';
import 'login/model/logout_request_model.dart';
import 'login/model/ris_request_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ExplanationsViewModel extends GetxController with CacheManager,PatientManager,PredictionManager{
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;
  late final PatientManagerObs _patientManager;
  RxString patientIDD="0000".obs;

  RxList<RiskExplanation> riskexplanations = <RiskExplanation>[].obs;
  //List<RiskExplanation> riskexplanations = <RiskExplanation>[];
  //////////RxRiskExplanationsDataSource riskexplanationDataSource=[].obs;
  final riskexplanationDataSource =Rxn<RiskExplanationsDataSource>();
  late RiskExplanationsDataSource riskexplanationDataSource2= RiskExplanationsDataSource(riskexplanationsData: riskexplanations);
  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
    _patientManager=Get.find();
    setPatientIDD();

    //riskexplanations = getRiskExplanationData();
    getRiskPredictionRules(getPatientIDD()!);
    //riskexplanationDataSource = RiskExplanationsDataSource(riskexplanationsData: riskexplanations);
  }

  Rxn<RiskExplanationsDataSource> getRiskExplanationsDataSource(){
    print("riskexplanationDataSource:" );

   // print(riskexplanationDataSource?._riskExplanationsData);
    //return riskexplanationDataSource;
    return riskexplanationDataSource;
  }

  RiskExplanationsDataSource? getRiskExplanationsDataSource2(RxList<RiskExplanation> riskexplanations){
    print("riskexplanationDataSource:" );
    // print(riskexplanationDataSource?._riskExplanationsData);
    if(riskexplanations.isEmpty){
      print("j");
      return null;
    }else{
      //riskexplanationDataSource2 = RiskExplanationsDataSource(riskexplanationsData: riskexplanations.value);
      print("length of riskexplanations ");
      print(riskexplanations.length);
      return RiskExplanationsDataSource(riskexplanationsData: riskexplanations);
    }
  }

  void setPatientIDD(){
    patientIDD.value=getPatientIDD()!;
  }
  //Get patientID from PatientManager
  String? getPatientIDD(){
    return getPatientID();
  }
  //Get patient name from PatientManager
  String? getPatientName(){
    return getPatientID();
  }

  //Log out user from risk menu screen
  Future<void> logoutUser() async {
    print("Trying to logout through search_patient_view_model");
    try {
      final response = await _loginService.fetchLogout(
          LogoutRequestModel(authtoken: getToken()));
      if (response != null) {
        print(response.token);
        _authManager.logOut();
        print(
            "Logged out user through search_patient_view_model: logout received");
      } else {
        print(
            "Logout user through search_patient_view_model: null response received");
      }
    }catch(e){
      print("Server is down");
    }
  }
  //Get risk prediction from server for specific patientID
  Future<void> getRiskPredictionRules(String patientID) async {

    final response = await _loginService.fetchriskexplanationsRequest(RisexplanationsRequestModel(patientID: patientID,token: getToken(),requesttype: 'riskexplanations_request'));

    String? jsonString=response?.explanations;
    //print(response);
    if (response != null) {
      print("Riskexplanations_view_model: response is not null");
      print(response.explanations);
      if (jsonString?.contains("logout") == null || jsonString?.contains("logout") == true) {
        print("User should be logged out from RisexplanationsRequestModel_view_model");
        _authManager.logOut();
      } else {
        //riskexplanation.value=jsonString!;

        print(jsonString);
        riskexplanations.value = parseExplanationString(jsonString!);
       // print("length of explanations:");
       // print(riskexplanations.length);
       //  for (RiskExplanation explanation in riskexplanations.value) {
       //    print("Description: ${explanation.description}");
       //    print("Covering Size: ${explanation.covering_size}");
       //    print("Fidelity: ${explanation.fidelity}");
       //    print("Train Confidence: ${explanation.train_confidence}");
       //    print("Train Accuracy: ${explanation.train_accuracy}");
       //    print("Ruleeeeeee");
       //    print("\n");
       //  }
        riskexplanationDataSource.value = RiskExplanationsDataSource(riskexplanationsData: riskexplanations);
        print("Received risk explanation successfully");
      }
    }else{
      print("Requested but did not received risk prediction");
    }
  }

  List<RiskExplanation> parseExplanationString(String explanationString) {
    List<RiskExplanation> explanations = [];

    // Extracting individual rule strings
    List<String> ruleStrings = explanationString.split(RegExp(r'R\d+: '));

    // Remove the first empty string from the list
    ruleStrings.removeAt(0);

    // Parse each rule string separately
    for (String ruleString in ruleStrings) {
      // Extracting necessary information using regular expressions
      RegExpMatch? match = RegExp(
          r'(.*?->.*?)Train Covering size : (\d+).*?Train Fidelity : (\d+).*?Train Accuracy : (\d+\.\d+).*?Train Confidence : (\d+\.\d+)')
          .firstMatch(ruleString);
      if (match != null) {
        final description = match.group(1)?.trim();
        final coveringSize = int.parse(match.group(2)!);
        final fidelity = int.parse(match.group(3)!);
        final trainAccuracy = double.parse(match.group(4)!);
        final trainConfidence = double.parse(match.group(5)!);

        // Create a RiskExplanation object
        RiskExplanation explanation = RiskExplanation(description!, coveringSize, fidelity, trainConfidence, trainAccuracy);

        // Add the explanation to the list
        explanations.add(explanation);
      } else {
        print('No match found for rule string: $ruleString');
      }
    }
   print("explanations");
    print(explanations);
    return explanations;
  }

  // List<RiskExplanation> getRiskExplanationData() {
  //   return [
  //     RiskExplanation('TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 --> NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1001, 200,0,0.984),
  //     RiskExplanation('TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 -->  NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1000, 150,0,0.925),
  //     RiskExplanation( 'TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 --> NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1000, 100,0,0.919),
  //     RiskExplanation('TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 -->  NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1090, 100,0,0.9889),
  //     RiskExplanation('TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 -->  NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1040, 100,0,0.981),
  //     RiskExplanation('TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 --> NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1080, 100,0,0.982),
  //     RiskExplanation('TREATED_BREAST_RADIO_UNKNOWN>=0.500000 NODES_EXAMINED<11.500000 WEIGHT<90.500000 --> NO_FOLLOW_UP_ARM_LYMPHEDEMA', 1100, 100,0,0.983),
  //   ];
  // }
  // void updateDataGridSource({required RowColumnIndex rowColumnIndex}) {
  //   riskexplanationDataSource.value?.updateDataGridSource(rowColumnIndex: rowColumnIndex);
  // }

}
/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class RiskExplanation {
  /// Creates the employee class with required details.
  RiskExplanation(this.description, this.covering_size,  this.fidelity, this.train_confidence,this.train_accuracy);

  /// Id of an employee.
  final int covering_size;

  /// Name of an employee.
  final String description;

  /// Designation of an employee.
  final int fidelity;

  /// Salary of an employee.
  final double train_confidence;

  final double train_accuracy;

  @override
  String toString() {
    return 'RiskExplanation{description: $description, coveringSize: $covering_size, fidelity: $fidelity, trainConfidence: $train_confidence, trainAccuracy: $train_accuracy}';
  }

}

/// An object to set the risk explanation collection data source to the datagrid. This
/// is used to map the risk explanation  data to the datagrid widget.
class RiskExplanationsDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  RiskExplanationsDataSource({required List<RiskExplanation> riskexplanationsData}) {
    _riskExplanationsData = riskexplanationsData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'description', value: e.description),
      DataGridCell<int>(columnName: 'covering_size', value: e.covering_size),
      DataGridCell<int>(columnName: 'fidelity', value: e.fidelity),
      DataGridCell<double>(
          columnName: 'train_confidence', value: e.train_confidence),
      DataGridCell<double>(
          columnName: 'train_accuracy', value: e.train_accuracy)
    ])).toList();

  }
  List<DataGridRow> _riskExplanationsData = [];

  @override
  List<DataGridRow> get rows => getrows();

 // @override
  List<DataGridRow> getrows() {
    List<DataGridRow> rows = [];
    for (DataGridRow row in _riskExplanationsData) {
      List<DataGridCell<dynamic>> cells = row.getCells();
      print("the row is:");
      print(DataGridRow(cells: cells));
      rows.add(DataGridRow(cells: cells));
      //rows.add(DataGridRow(cells: cells));
    }
    return rows;
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final List<Widget> cellWidgets = row.getCells().map((cell) {
      print(cell.value.toString());
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0.0),
        child: Text(
          cell.value.toString(),
          style: TextStyle(fontSize: 11.0),
        ),
      );
    }).toList();
    print("cellWidgets");
    print(cellWidgets);
    return DataGridRowAdapter(cells: cellWidgets);
  }

}