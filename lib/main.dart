import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:flutterscanner/register.dart';
import 'drawer.dart';
import 'firebase_options.dart';
import 'splashscreen.dart';
import 'constants.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsApp.debugAllowBannerOverride = false;
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Kmaincolor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filepath = "";
  String? Getpath() {
    getFromGallery();
    return filepath;
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        // imageFile = File(pickedFile.path);
        filepath = pickedFile.path;
      });
    }
  }

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const HomePage()),
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
        child: MainDrawer(),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Welcome To Flutter Scanner",
              style: TextStyle(
                  color: Kmaincolor, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Not yet Register? Click below to register !",
              style: TextStyle(
                  color: Kmaincolor, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Register())));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ))
        ]),
      ),
      //
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
