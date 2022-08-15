import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uidesign/auth.dart';

import 'navigation.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(

        ),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('FireBase Test'),
        ),
        body: Center(
          child: Builder(
            builder: (context) => Container(
              alignment: Alignment.center,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                    ),
                  primary: Colors.blueAccent,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.open_in_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                          "Open Drawer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ),
    );
  }
}


