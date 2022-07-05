import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterscanner/Model/UserModel.dart';
import 'package:flutterscanner/main.dart';
import '/constants.dart';

class DashDrawer extends StatefulWidget {
  const DashDrawer({Key? key}) : super(key: key);

  @override
  State<DashDrawer> createState() => _DashDrawerState();
}

class _DashDrawerState extends State<DashDrawer> {
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  UserModel LoggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.email)
        .get()
        .then((value) {
      LoggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Kmaincolor,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Kmaincolor,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, bottom: 40),
                  child: Row(
                    children: [
                      const Text(
                        "Welcome,",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        LoggedInUser.username.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
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
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
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
                "Dashboard",
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
                "New File",
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
                logout(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Logout"),
                ],
              )),
          const SizedBox(
            height: 100,
          ),
          const Text(
            "Version: V.2.0",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Kmaincolor),
          ),
        ],
      ),
    );
  }
}
