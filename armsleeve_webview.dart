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

class armsleeve_webview extends StatefulWidget {
  //const SearchPatientView({Key? key}) : super(key: key);
  @override
  _armsleeve_webview createState() => _armsleeve_webview();
}

class _armsleeve_webview extends State<armsleeve_webview> {
  AuthenticationManager _authManager = Get.find();

  //here starts the sleeve jpg display
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Armsleeve installation instructions"),
        centerTitle: true,
          actions: [
                IconButton(
                  onPressed: () {
                   // await _viewModel.logoutUser();
                    _authManager.logOut();
                    Get.off(LoginView());
                  },
                  icon: Icon(Icons.logout_rounded),
                )
        //       ],
        //backgroundColor: Colors.blue[900],
      ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset(
          "images/armsleeve.jpg",
          height: 200,
          width: 200,
        ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const HomeView()),
            //     );
            //   },
            //   child: Text('Back'),
            // ),
          ],
        ),
      ),
    );
  } //here is the .jpg file displayed

}
  //send pdf file to client
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Home'),
  //       actions: [
  //         IconButton(
  //           onPressed: () {
  //             _authManager.logOut();
  //           },
  //           icon: Icon(Icons.logout_rounded),
  //         )
  //       ],
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text('HOME VIEW'),
  //           ElevatedButton(
  //             child: Text('Button'),
  //             onPressed: () {
  //               js.context.callMethod(
  //                   'open', ['https://stackoverflow.com/questions/ask']);
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

//send pdf file to client
// late File Pfile;
  // bool isLoading = false;
  // Future<void> loadNetwork() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var url = 'http://localhost:8080/preact/HelloServlet';
  //   // var url = 'http://www.pdf995.com/samples/pdf.pdf';
  //  // var url='file:///home/preact/Downloads/mypdf.pdf';
  //   final response = await http.get(Uri.parse(url));
  //   final bytes = response.bodyBytes;
  //   final filename = basename(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //   var file = File('${dir.path}/$filename');
  //   await file.writeAsBytes(bytes, flush: true);
  //   print(filename);
  //   print(dir);
  //   setState(() {
  //     Pfile = file;
  //   });
  //
  //   print(Pfile);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   loadNetwork();
  //
  //   super.initState();
  // }
  //

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         "Arm Sleeve",
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //     body: isLoading
  //         ? Center(child: CircularProgressIndicator())
  //         : Container(
  //       child: Center(
  //         child: PDFView(
  //           filePath: Pfile.path,
  //         ),
  //       ),
  //     ),
  //   );
  // }

