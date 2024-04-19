import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:js' as js;
import 'core/authentication_manager.dart';
import 'home_view.dart';
import 'login/login_view.dart';

class radiotherapy_webview extends StatefulWidget {
  //const SearchPatientView({Key? key}) : super(key: key);
  @override
  _radiotherapy_webview createState() => _radiotherapy_webview();
}

class _radiotherapy_webview extends State<radiotherapy_webview> {
  AuthenticationManager _authManager = Get.find();
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  //here starts the sleeve jpg display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcde3f8),
      appBar: AppBar(
        title: Text('About radiotherapy'),
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
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          // ),
          // backgroundColor: Colors.grey[200]
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
              // child: Text(
              //   '',
              //   style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              // ),
            ),
          ),
        ),
        items: [
          SideMenuItem(
            title: 'Patients',
            onTap: (index, _) {
              Get.offAll(HomeView());
            },
            icon: const Icon(Icons.supervisor_account),
            // badgeContent: const Text(
            //   '',
            //   style: TextStyle(color: Colors.white),
            // ),
            tooltipContent: "This is a tooltip for Dashboard item",
          ),
          SideMenuItem(
            title: 'About radiotherapy',
            onTap: (index, _) {
              sideMenu.changePage(index);
            },
            icon: const Icon(Icons.radar_outlined),
          ),
          // SideMenuExpansionItem(
          //   title: "Expansion Item",
          //   icon: const Icon(Icons.kitchen),
          //   children: [
          //     SideMenuItem(
          //       title: 'Expansion Item 1',
          //       onTap: (index, _) {
          //         sideMenu.changePage(index);
          //       },
          //       icon: const Icon(Icons.home),
          //       badgeContent: const Text(
          //         '3',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       tooltipContent: "Expansion Item 1",
          //     ),
          //     SideMenuItem(
          //       title: 'Expansion Item 2',
          //       onTap: (index, _) {
          //         sideMenu.changePage(index);
          //       },
          //       icon: const Icon(Icons.supervisor_account),
          //     )
          //   ],
          // ),
          SideMenuItem(
            title: 'About lymphoedema',
            onTap: (index, _) {
              sideMenu.changePage(index);
            },
            icon: const Icon(Icons.file_copy_rounded),
            trailing: Container(
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 3),
                  child: Text(
                    'New',
                    style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                  ),
                )),
          ),
          SideMenuItem(
            title: 'About armsleeve',
            onTap: (index, _) {
              //sideMenu.changePage(index);
              //Get.to(SearchPatientView());
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
            onTap: (index,_) {
              //await _viewModel.logoutUser();
              _authManager.logOut();
              Get.offAll(LoginView());
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      Expanded(child: PageView(
          controller: pageController,
          children: [
            Container(
              color: Colors.white,
              child:  Center(
                     child:  Image.asset(
                    "images/armsleeve.jpg",
                    height: 400,
                    width: 300,
                  ),
              ),
            ),Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
          ]
      ))
    ]));
  } //here is the .jpg file displayed
}

