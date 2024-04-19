import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/core/patient_manager.dart';
import 'package:auth_manager/patientmenu_view_model.dart';
import 'package:auth_manager/riskdetails_view.dart';
import 'package:auth_manager/riskmenu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'armsleeve_webview.dart';
import 'core/patient_manager_obs.dart';
import 'explanations_view_model.dart';
import 'login/home_view_model.dart';
import 'login/login_view.dart';
import 'login/searchpatient_view.dart';
import 'dart:js' as js;

class ExplanationsView extends StatefulWidget with PatientManager {
  const ExplanationsView({Key? key}) : super(key: key);

  @override
  _ExplanationsView createState() => _ExplanationsView();
}

class _ExplanationsView extends State<ExplanationsView> {
  AuthenticationManager _authManager = Get.find();
  ExplanationsViewModel _viewModel = Get.put(ExplanationsViewModel());
  late RiskExplanationsDataSource riskexplanationDataSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Risk Explanations'),
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
      body: Column(
        children: [
          //body:
          Expanded(
            child: Obx(
              () {
                final dataSource = _viewModel.getRiskExplanationsDataSource2(
                    _viewModel.riskexplanations);
                return dataSource != null
                    ? SfDataGrid(
                        shrinkWrapRows: true,
                        source: dataSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSorting: true,
                        allowMultiColumnSorting: false,
                        //When user selects a row, do something:
                        // onCellTap: (DataGridCellTapDetails details) {
                        //            Get.offAll(LoginView());
                        // },
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: 'Description',
                              label: Container(
                                  padding: EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'description',
                                  ),),),
                          GridColumn(
                              columnName: 'covering_size',
                              label: Container(
                                  padding: EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  child: Text('Covering size'))),
                          GridColumn(
                              columnName: 'fidelity',
                              label: Container(
                                  padding: EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Fidelity',
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                          GridColumn(
                              columnName: 'train_confidence',
                              label: Container(
                                  padding: EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  child: Text('Train confidence'),),),
                          GridColumn(
                              columnName: 'train_accuracy',
                              label: Container(
                                  padding: EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  child: Text('Train Accuracy'),),),
                        ],
                      )
                    : CircularProgressIndicator();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!_authManager.checkLoginStatus2()) {
                Get.offAll(LoginView());
              } else {
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'Data is retrieved successfully',
                    icon: const Icon(Icons.dangerous),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text("Refresh"),
          )
        ],
      ),
    );
  }
}
