import 'package:flutter/material.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:flutterscanner/User/dashdrawer.dart';
import 'package:flutterscanner/User/pdf.dart';
import 'package:flutterscanner/constants.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String filepath = "";
  // String? Getpath() {
  //   getFromGallery();
  //   return filepath;
  // }

  // getFromGallery() async {
  //   XFile? pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       // imageFile = File(pickedFile.path);
  //       filepath = pickedFile.path;
  //     });
  //   }
  // }

  Future<Directory> copyLanguageFile() async {
    Directory languageFolder = await getApplicationSupportDirectory();
    File languageFile = File(languageFolder.path + "/eng.traineddata");
    if (!languageFile.existsSync()) {
      ByteData data = await rootBundle.load("assets/eng.traineddata");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await languageFile.writeAsBytes(bytes);
    }
    return languageFolder;
  }

  void displayError(BuildContext context, PlatformException error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.message!)));
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        FlutterGeniusScan.setLicenceKey(
            '533c5006515e0400045c0f5439525a0e4a064a0559465e5c4c505813434c55421157050c565044685404040a515b05035a51');
        copyLanguageFile().then((folder) {
          FlutterGeniusScan.scanWithConfiguration({
            'source': 'camera',
            'highlightColor': '#FF0000',
            'multiPage': true,
            'ocrConfiguration': {
              'languages': ['eng'],
              'languagesDirectoryUrl': folder.path
            }
          }).then((result) {
            String documentUrl = result['multiPageDocumentUrl'];
            OpenFile.open(documentUrl.replaceAll("file://", '')).then(
                (result) => debugPrint(result.message),
                onError: (error) => displayError(context, error));
          }, onError: (error) => displayError(context, error));
        });
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const Dashboard()),
          ),
        );
      } else if (_selectedIndex == 2) {
        // filepath = "";
        // FlutterGeniusScan.setLicenceKey(
        //     '533c5006515e0400045c0f5439525a0e4a064a0559465e5c4c505813434c55421157050c565044685404040a515b05035a51');
        // copyLanguageFile().then((folder) {
        //   FlutterGeniusScan.scanWithConfiguration({
        //     'source': 'image',
        //     'sourceImageUrl': Getpath(),
        //     'multiPage': true,
        //     'ocrConfiguration': {
        //       'languages': ['eng'],
        //       'languagesDirectoryUrl': folder.path
        //     }
        //   }).then((result) {
        //     String documentUrl = result['multiPageDocumentUrl'];
        //     OpenFile.open(documentUrl.replaceAll("file://", '')).then(
        //         (result) => debugPrint(result.message),
        //         onError: (error) => displayError(context, error));
        //   }, onError: (error) => displayError(context, error));
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Scanner"),
        centerTitle: true,
      ),
      drawer: const Drawer(
        elevation: 2.0,
        child: DashDrawer(),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Recent History",
              style: TextStyle(
                color: Kmaincolor,
                fontSize: 25,
              ),
            ),
          ),
          Center(
            child: PDF(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.camera,
              size: 40,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.image,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
