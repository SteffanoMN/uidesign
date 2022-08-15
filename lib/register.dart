import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'const.dart';
import 'home.dart';
import 'loading.dart';

class Register extends StatefulWidget {
  // final Function val;

  Register({
    Key? key,
    /* required this.val */
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

List<FocusNode> _focusNodes = [
  FocusNode(),
  FocusNode(),
  FocusNode(),
  FocusNode(),
  FocusNode(),
];

class _RegisterState extends State<Register> {

  final AuthService auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  SharedPreferences? sharedPref;

  TextEditingController textmamen = TextEditingController();

  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  bool confirm = false;
  String error = '';

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            home: Scaffold(
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Colors.green,
                                )),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Create a new account',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formkey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Column(children: <Widget>[
                                SizedBox(height: 20),
                                TextFormField(
                                    focusNode: _focusNodes[0],
                                    style: getTextColor(_focusNodes[0]),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.person_outline,
                                            color: getPrefixIconColor(
                                                _focusNodes[0])),
                                        labelText: 'NAME',
                                        labelStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500)),
                                    onChanged: (val) {
                                      setState(() => name = val);
                                    }),
                                SizedBox(height: 20),
                                TextFormField(
                                  focusNode: _focusNodes[1],
                                  style: getTextColor(_focusNodes[1]),
                                  controller: textmamen,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color: getPrefixIconColor(
                                              _focusNodes[1])),
                                      labelText: 'EMAIL',
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500)),
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  focusNode: _focusNodes[2],
                                  style: getTextColor(_focusNodes[2]),
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.smartphone,
                                          color: getPrefixIconColor(
                                              _focusNodes[2])),
                                      labelText: 'PHONE',
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500)),
                                    validator: (val) =>
                                    val!.isNotEmpty && val.length < 8
                                        ? "please type in a valid phone number"
                                        : null,
                                  onChanged: (val) {
                                    setState(() => phone = val);
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  focusNode: _focusNodes[3],
                                  style: getTextColor(_focusNodes[3]),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: getPrefixIconColor(
                                              _focusNodes[3])),
                                      labelText: 'PASSWORD',
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500)),
                                  obscureText: true,
                                  validator: (val) =>
                                    val!.isNotEmpty && val.length < 8
                                        ? "Password is too short"
                                        : null
                                  ,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                                SizedBox(height: 25),
                                TextFormField(
                                  focusNode: _focusNodes[4],
                                  style: getTextColor(_focusNodes[4]),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: getPrefixIconColor(
                                              _focusNodes[4])),
                                      labelText: 'CONFIRM PASSWORD',
                                      labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500)),
                                  obscureText: true,
                                  validator: (val) =>
                                    password.isNotEmpty && val != password
                                            ? "type in the correct password"
                                            : null
                                ),
                              ]),
                            ),
                            SizedBox(height: 35),
                            Container(
                              height: 58,
                              width: 390,
                              decoration: BoxDecoration(
                                  color: Color(0xff01BA76),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: TextButton(
                                  onPressed: () async {
                                    if (name.isEmpty || email.isEmpty ||
                                        phone.isEmpty || password.isEmpty){
                                      print('please fill in the boxes');
                                    } else if (textmamen.text.contains("@gmail.com")){
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
                                    "CREATE ACCOUNT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(color: Colors.green[600]),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Bruhmoment');
                                    Navigator.of(context).pop();
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
