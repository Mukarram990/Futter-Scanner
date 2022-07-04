import 'package:flutter/material.dart';
import 'constants.dart';
import 'login.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Kmaincolor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.document_scanner_rounded,
                      color: Kmaincolor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Flutter Scanner",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                      //textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          ListTileTheme(
            data: klistdata,
            child: ListTile(
              onTap: () {},
              selected: true,
              leading: const Icon(
                Icons.home_outlined,
              ),
              title: const Text(
                "Home",
                style: ktextstyle,
              ),
            ),
          ),
          ListTileTheme(
            data: klistdata,
            child: ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.file_copy,
              ),
              title: const Text(
                "Create New File",
                style: ktextstyle,
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                maximumSize: const Size(150, 40),
                fixedSize: const Size(150, 40),
                minimumSize: const Size(150, 40),
                textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: const BorderSide(color: Colors.red)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text("Login/Register")),
          const SizedBox(
            height: 100,
          ),
          const Text(
            "Version: V.1.0",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Kmaincolor),
          ),
        ],
      ),
    );
  }
}
