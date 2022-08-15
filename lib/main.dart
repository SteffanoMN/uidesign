import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign/register.dart';
import 'package:uidesign/signin.dart';

import 'auth.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
        home: Home(),
      );
  }
}
