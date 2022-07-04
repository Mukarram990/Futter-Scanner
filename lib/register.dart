import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterscanner/Model/UserModel.dart';
import 'package:flutterscanner/constants.dart';
import 'package:flutterscanner/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  // final FocusNode focusEmail = FocusNode();
  // final FocusNode focusPassword = FocusNode();
  // final FocusNode focusName = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  // Sign Up Method
  void signUp(String email, String pass) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) => {
                postDetailsToFireStore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: "Error Registering You");
      });
    }
  }

  postDetailsToFireStore() async {
    FirebaseFirestore fbfs = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel model = UserModel(
      username: nameController.text,
      email: emailController.text,
      pass: passwordController.text,
    );
    await fbfs.collection("user").doc(user!.email).set(model.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Scanner"),
        centerTitle: true,
      ),
      body: Stack(children: [
        Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register',
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
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a valid Username' : null,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) => value!.isEmpty &
                          !RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                              .hasMatch(value)
                      ? 'Enter a valid Email'
                      : null,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) => value!.length < 6
                      ? 'Enter password greater than 6 characters'
                      : null,
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) => value != passwordController.text
                      ? 'Password do not match'
                      : null,
                  obscureText: true,
                  controller: confirmpasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
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
                    child: const Text('Sign Up'),
                    onPressed: () {
                      signUp(emailController.text, passwordController.text);
                    },
                  )),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  const Text('Already Registered?'),
                  TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
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
        ),
        isLoading
            ? Container(
                color: Colors.white60,
                child: SpinKitSquareCircle(
                    color: Kmaincolor,
                    size: 50.0,
                    controller: AnimationController(
                        vsync: this,
                        duration: const Duration(milliseconds: 3000))),
              )
            : Stack()
      ]),
    );
  }
}
