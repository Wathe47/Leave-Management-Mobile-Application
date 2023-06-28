import 'package:flutter/material.dart';
import 'package:frontend/roster.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/checkin.dart';
import 'package:frontend/leave.dart';
import 'package:frontend/test.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Signin(),
  ));
}
