import 'package:flutterscanner/login.dart';
import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Scanner"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Reset Password',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Reset'),
                onPressed: () {
                  // ignore: avoid_print
                  print(emailController.text);
                  // ignore: avoid_print
                },
              )),
          const SizedBox(
            height: 25,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              )),
        ],
      ),
    );
  }
}
