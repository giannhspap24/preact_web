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
  RiskDetailsViewModel _viewModel = Get.put(RiskDetailsViewModel());
  String patientIDD="0000";
  late RxString patientrisk="0000".obs;
  String explanation="Highh BMI";
  //final String globalUrl = 'http://195.251.234.22:8080/preact/HelloServlet';
  final List<ChartData> chartData = [
    ChartData('Low', 20),
    ChartData('High', 80)
  ];
  Future<void> initializeSettings() async {
    //Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 3));
  }
  @override
  Widget build(BuildContext context) {



    // if(patientrisk.contains("low")){
    //     List<ChartData> chartData = [
    //     ChartData('Low', 80),
    //     ChartData('High', 20)
    //   ];
    // }else{
    //    List<ChartData> chartData = [
    //     ChartData('Low', 20),
    //     ChartData('High', 80)
    //   ];
    // }


     if(_viewModel.getPatientIDD() !=null){
       patientIDD=_viewModel.getPatientIDD()!;
       _viewModel.getRiskPrediction(patientIDD); //needs await
     }
     if(_viewModel.getPredictionClass() !=null){
       patientrisk.value=_viewModel.getPrediction()!;
     }
     initializeSettings();
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
            Text("Detailed risk assessment for patientID:"+patientIDD),

            Text("Risk prediction:"+patientrisk.value),
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
                await _viewModel.getRiskReport(patientIDD);
                //js.context.callMethod('open', [globalUrl]);
              },
              // onPressed: () {
              //   _viewModel.getRiskReport(patientIDD);
              // },
              child: Text('Download Risk assessment report(PDF)'),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //     body: Center(
    //         child: Container(
    //             child: SfCircularChart(
    //                 series: <CircularSeries>[
    //                   // Render pie chart
    //                   PieSeries<ChartData, String>(
    //                       dataSource: chartData,
    //                       pointColorMapper: (ChartData data, _) => data.color,
    //                       xValueMapper: (ChartData data, _) => data.x,
    //                       yValueMapper: (ChartData data, _) => data.y
    //                   )
    //                 ]
    //             )
    //         );
    //     )
    // );
  }
}
class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}