import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

final TextInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(left: 20),
  fillColor: Colors.white.withOpacity(0.2),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Colors.green)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Colors.white)),
  hintText: "Hint",
  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
);
