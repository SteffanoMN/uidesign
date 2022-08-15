import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uidesign/register.dart';
import 'auth.dart';
import 'const.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

List<FocusNode> _focusNodes = [
  FocusNode(),
  FocusNode(),
];

class _SignInState extends State<SignIn> {
  final AuthService auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  bool isMamen = false;
  bool isPapi = false;

  TextEditingController textmamen = TextEditingController();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Icon(
                  Icons.person,
                  size: 150,
                  color: Colors.grey.shade300,
                ),
                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                      fontSize: 36, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Sign to continue",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(children: <Widget>[
                              Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme:
                                          ThemeData().colorScheme.copyWith(
                                                primary: Colors.green,
                                              )),
                                  child: Material(
                                    elevation: isMamen ? 5 : 0,
                                    shadowColor: Colors.white70,
                                    child: TextFormField(
                                        style: TextStyle(
                                            color: isMamen
                                                ? Colors.green
                                                : Colors.grey),
                                        onTap: () {
                                          setState(() {
                                            isMamen = true;
                                            isPapi = false;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon:
                                              Icon(Icons.email_outlined),
                                          labelText: 'EMAIL',
                                          labelStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.w500),
                                          focusedBorder: OutlineInputBorder(
                                              gapPadding: 5,
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        controller: textmamen,
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        }),
                                  )),
                              SizedBox(
                                height: 35,
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme:
                                        ThemeData().colorScheme.copyWith(
                                              primary: Colors.green,
                                            )),
                                child: Material(
                                  elevation: isPapi ? 5 : 0,
                                  shadowColor: Colors.white70,
                                  textStyle: TextStyle(color: Colors.green),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isPapi
                                            ? Colors.green
                                            : Colors.grey),
                                    onTap: () {
                                      setState(() {
                                        isMamen = false;
                                        isPapi = true;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock_outline),
                                      labelText: 'PASSWORD',
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500),
                                      focusedBorder: OutlineInputBorder(
                                          gapPadding: 5,
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    obscureText: true,
                                    validator: (val) =>
                                      val!.isNotEmpty && val.length < 8 ?
                                        "Password is too short" :
                                      val != "admin123" ? "incorrect password" :
                                      null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 58,
                                width: 390,
                                decoration: BoxDecoration(
                                    color: Color(0xff01BA76),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: TextButton(
                                    onPressed: () async {
                                      if (email.isEmpty || password.isEmpty) {
                                        print('please fill in the boxes');
                                      } else if (textmamen.text
                                          .contains("@gmail.com")) {
                                        print("KURANG");
                                        if (_formkey.currentState!.validate()) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()));
                                          // setState(() async {
                                          //   await sharedPref!.setString('name', name);
                                          //   await sharedPref!.setString('email', email);
                                          //   await sharedPref!.setString('phone', phone);
                                          //   await sharedPref!.setString('password', password);
                                          // });
                                          // print(sharedPref!.get('name').toString());
                                        }
                                      } else {
                                        print("your email is invalid");
                                      }
                                    },
                                    child: Text(
                                      "LOGIN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Don't have account? ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'create a new account',
                                      style:
                                          TextStyle(color: Colors.green[600]),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Bruhmoment');
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()));
                                        },
                                    ),
                                  ],
                                ),
                              )
                            ]))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
