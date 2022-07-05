import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutterscanner/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PDF extends StatefulWidget {
  const PDF({Key? key}) : super(key: key);

  @override
  State<PDF> createState() => _PDFState();
}

class _PDFState extends State<PDF> {
  dynamic printpath() async {
    var externalDirectoryPath = await getExternalStorageDirectory();
    return externalDirectoryPath?.path;
  }

  String? directory;
  List file = [];
  Future<void> getFiles() async {
    directory = await printpath();
    setState(() {
      file = io.Directory(directory.toString()).listSync();
    });
  }

  void openFile(String file) {
    OpenFile.open(file);
  }

  @override
  void initState() {
    getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // your Content if there
          Expanded(
            child: ListView.builder(
                itemCount: file.length,
                itemBuilder: (BuildContext context, int index) {
                  String name = p.basename(file[index].toString());
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Expanded(
                      child: Card(
                          color: Kmaincolor,
                          shadowColor: Kmaincolor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              name.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
