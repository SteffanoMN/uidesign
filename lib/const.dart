import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Color getPrefixIconColor(FocusNode focusNode){
  return focusNode.hasFocus ? Colors.green : Colors.grey;
}

TextStyle getTextColor(FocusNode focusNode) {
  return focusNode.hasFocus? TextStyle(
      color: Colors.green[600],
      fontWeight: FontWeight.w500
  ) : TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500
  );
}