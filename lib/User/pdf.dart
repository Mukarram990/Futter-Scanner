import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//import package files

//apply this class on home: attribute at MaterialApp()
class MyPDFList extends StatefulWidget {
  const MyPDFList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPDFList(); //create state
  }
}

class _MyPDFList extends State<MyPDFList> {
  // ignore: prefer_typing_uninitialized_variables
  var files;
  dynamic printpath() async {
    var externalDirectoryPath = await getExternalStorageDirectory();
    return externalDirectoryPath?.path;
  }

  void getFiles() async {
    // //asyn function to get list of files
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0]
    //     .rootDir; //storageInfo[1] for SD card, geting the root directory
    // var fm = FileManager(
    //     root: Directory(
    //         "/storage/emulated/0/Android/data/com.example.flutterscanner")); //
    // files = await fm.filesTree(
    //     // excludedPaths: ["/storage/emulated/0/Android"],
    //     extensions: ["pdf"]);
    // setState(() {});
  }

  @override
  void initState() {
    getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return files == null
        ? const Text("Searching Files")
        : ListView.builder(
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(files[index].path.split('/').last),
                leading: const Icon(Icons.picture_as_pdf),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return ViewPDF(pathPDF: files[index].path.toString());
                  //   //open viewPDF page on click
                  // }));
                },
              ));
            },
          );
  }
}

// // ignore: must_be_immutable
// class ViewPDF extends StatelessWidget {
//   String pathPDF = "";
//   ViewPDF({Key? key, pathPDF}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PDFViewerScaffold(
//         //view PDF
//         appBar: AppBar(
//           title: const Text("Document"),
//           backgroundColor: Colors.deepOrangeAccent,
//         ),
//         path: pathPDF);
//   }
// }
