import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterscanner/User/dashboard.dart';
import 'package:flutterscanner/constants.dart';
import 'package:flutterscanner/forgetpass.dart';
import 'package:flutterscanner/main.dart';
import 'package:flutterscanner/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutterscanner/drawer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  //  Variables

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Spin kit
  bool isLoading = false;
  //For Login
  void signIn(String email, String pass) async {
    if (_formkey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await _auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) => {
                // toggleIsloading(false),
                Fluttertoast.showToast(msg: "Login Successfully"),
                setPref(emailController.text),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => const Dashboard())))
              })
          .catchError((e) {
        // ignore: invalid_return_type_for_catch_error
        return Fluttertoast.showToast(msg: "Incorrect Email or Password");
      });
    }
  }

  Future setPref(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("email", email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          icon: const Icon(Icons.navigate_before),
          color: Colors.white,
        ),
        title: const Text("Flutter Scanner"),
        centerTitle: true,
      ),
      // drawer: const Drawer(
      //   elevation: 2.0,
      //   child: MainDrawer(),
      // ),
      body: Stack(
        children: <Widget>[
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
                      'Login',
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        signIn(emailController.text, passwordController.text);
                      },
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Forget())));
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
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
        ],
      ),
    );
  }
}
