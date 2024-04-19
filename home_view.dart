import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/radiotherapy_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'armsleeve_webview.dart';
import 'login/home_view_model.dart';
import 'login/login_view.dart';
import 'login/searchpatient_view.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'lymphoedema_webview.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();

}

class _HomeViewState extends State<HomeView> {
  AuthenticationManager _authManager = Get.find();
  HomeViewModel _viewModel = Get.put(HomeViewModel());
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  Widget build(BuildContext context) {
    print("Built home view");

    return Scaffold(
        backgroundColor: Color(0xFFcde3f8),
        appBar: AppBar(
          title: Text('Patients'),
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            title: Column(),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Patients',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'About radiotherapy',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.offAll(radiotherapy_webview());
                },
                icon: const Icon(Icons.radar_outlined),
              ),
              SideMenuItem(
                title: 'About lymphoedema',
                onTap: (index, _) {
                  Get.offAll(lymphoedema_webview());
                },
                icon: const Icon(Icons.file_copy_rounded),
              ),
              SideMenuItem(
                title: 'About armsleeve',
                onTap: (index, _) {
                  //sideMenu.changePage(index);
                  Get.offAll(armsleeve_webview());
                },
                icon: const Icon(Icons.scanner),
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider(
                    endIndent: 8,
                    indent: 8,
                  );
                },
              ),
              SideMenuItem(
                title: 'About Pre-Act',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.info),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
                SideMenuItem(
                title: 'Log out',
                onTap: (index,_) async{
                  await _viewModel.logoutUser();
                  _authManager.logOut();
                  Get.offAll(LoginView());
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          //const VerticalDivider(width: 0,),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Expansion Item 1',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Expansion Item 2',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),

                // this is for SideMenuItem with builder (divider)
                const SizedBox.shrink(),

                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           //GET.TO FOR THE screens we want to go back
      //           //otherwise use get.off(view())
      //           Get.to(SearchPatientView());
      //         },
      //         child: Text('Patients'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //            // initializeSettings();
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('Treatment info'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //             //initializeSettings();
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('General information'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //             //initializeSettings();
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('Practical info'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //            // initializeSettings();
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('Shared Experience'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //           //  initializeSettings();
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('Source referencing'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //            // initializeSettings();
      //             Get.to(armsleeve_webview());
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('Arm Sleeve'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if(_authManager.checkLoginStatus2()){
      //             print("Press");
      //             //initializeSettings();
      //           }else{
      //             Get.off(LoginView());
      //           }
      //         },
      //         child: Text('About'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

}

