import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class AuthService{

     SharedPreferences? sharedPref;

     int akuncount = 1;

     bool get user{
          String validate = sharedPref!.getString('email').toString();
          return validate != null ? true : false;
     }

     Register(String name, String email, String phone, String password) async {
       try {
         sharedPref = await SharedPreferences.getInstance();
         if (sharedPref == null) {
           sharedPref!.setString('name', name);
           sharedPref!.setString('email', email);
           sharedPref!.setString('phone', phone);
           sharedPref!.setString('password', password);
         }
         print(sharedPref!.get('name').toString());
       } catch (e) {
         print(e.toString());
         return null;
       }
     }

     SignIn(String email, String password) async {
          try {
              List<String> value = [];
              sharedPref = await SharedPreferences.getInstance();
              for (String key in sharedPref!.getKeys()){
                value.add(sharedPref!.get(key).toString());
                if (value.contains(email) && value.contains(password)) {
                  return true;
                } else {
                  return false;
                }
               }
          } catch(e) {
               print(sharedPref);
               print(e.toString());
               return null;
          }
     }


}