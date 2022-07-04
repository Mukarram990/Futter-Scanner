import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
                  return Text(file[index].toString());
                }),
          )
        ],
      ),
    );
  }
}
