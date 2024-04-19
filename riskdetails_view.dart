import 'dart:io';

import 'package:auth_manager/riskdetails_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:js' as js;
import 'core/authentication_manager.dart';
import 'login/login_view.dart';

class RiskDetailsView extends StatefulWidget {
  const RiskDetailsView({Key? key}) : super(key: key);
  @override
  _RiskDetailsView createState() => _RiskDetailsView();

}

class _RiskDetailsView extends State<RiskDetailsView> {
  AuthenticationManager _authManager = Get.find();
  RiskDetailsViewModel _viewModel = Get.put(RiskDetailsViewModel()); //

  //final String globalUrl = 'http://195.251.234.22:8080/preact/HelloServlet';
  final List<ChartData> chartData = [
    ChartData('Low', 20),
    ChartData('High', 80)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Risk Details'),
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
            //Text("Detailed risk assessment for patientID:"+patientIDD),
            Obx(() {
              return Text("Detailed risk assessment for patientID:"+_viewModel.patientIDD.value);
            }),
            Obx(() {
              return Text("Risk prediction:"+_viewModel.patientrisk.value);
            }),
            //Text("Risk prediction:"+_viewModel.patientrisk.value),
            Container(
                child: SfCircularChart(
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      )
                    ]
                )
            ),
            Text("Explanations of risk prediction"),
            Text("Suggestions to minimize risk"),
            ElevatedButton(
              onPressed: () async {
                await _viewModel.getRiskReport(_viewModel.patientIDD.value);
                //js.context.callMethod('open', [globalUrl]);
              },
              // onPressed: () {
              //   _viewModel.getRiskReport(patientIDD);
              // },
              child: Text('Download Risk assessment report(PDF)'),
            ),ElevatedButton(onPressed: () async {
              if(!_authManager.checkLoginStatus2()){ Get.offAll(LoginView());}else{
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'Data is retrieved successfully',
                    icon: const Icon(Icons.dangerous),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }

            }, child: Text("Refresh"))
          ],
        ),
      ),
    );
  }
}
class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}