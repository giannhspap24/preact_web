import 'package:auth_manager/login/login_view.dart';
import 'package:auth_manager/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PRE- ACT',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
          //scaffoldBackgroundColor: const Color(0x00F4FF)
      ),
      home: SplashView(),
    );
  }
}
