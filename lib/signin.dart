import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/signup.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future save() async {
    print("Save Pressed");
    var response = await http.post("http://192.168.80.1:3001/api/users/login",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'email': _emailController.text,
            'password': _passwordController.text,
          },
        ));

    print(response.body);

    if (response.statusCode == 200) {
      // Successful login
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      final name = responseData['data']['user']['name'];
      print(name);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => Dashboard(
                    responseData: responseData,
                  )));
      // TODO: Handle the token, e.g., store it locally or pass it to the next screen
    } else {
      // Login failed
      final responseData = jsonDecode(response.body);
      setState(() {
        _errorMessage = responseData['message'];
      });

      _showSnackBar(_errorMessage);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior
            .floating, // Make the SnackBar float above the content
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Add rounded corners to the SnackBar
        ),
        backgroundColor: Color.fromARGB(
            255, 253, 32, 32), // Set the background color of the SnackBar
        // contentTextStyle: TextStyle(color: Colors.white), // Set the text color of the SnackBar content
        elevation:
            4, // Set the duration for which the SnackBar should be visible
      ),
    );
  }

  User user = User('', '', '', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 120,
            left: 170,
            child: Image(
              image: AssetImage('images/logo.png'),
              height: 120, // set the height of the image to 200
              width: 160, // set the width of the image to 300
              fit: BoxFit.cover, // scale the image to cover the entire widget
              alignment: Alignment.center, // center the image inside the widget
            )),
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                ),
                Text(
                  "Signin",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.orange),
                ),
                SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: 80,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _emailController,
                      onSaved: (value) {
                        _emailController.text = value;
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          _showSnackBar("Enter Emaail");
                        } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return null;
                        } else {
                          _showSnackBar('Enter valid email');
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.black),
                          hintText: 'Enter Email',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 143, 142, 142))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _passwordController,
                      onSaved: (value) {
                        _passwordController.text = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          _showSnackBar('Enter Password');
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 143, 142, 142))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                    child: Container(
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                          ),
                          onPressed: () {
                            print(_emailController.text);
                            print(_passwordController.text);
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              save();
                            } else {
                              print("Something went Wrong");
                            }
                          },
                          child: Text(
                            "Signin",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                    height: 80,
                    width: 350,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "No Account ? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: Color(0xFF2F5F30),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: SvgPicture.asset(
            'images/wave.svg',
            width: 400,
            height: 150,
          ),
        ),
      ],
    ));
  }
}
