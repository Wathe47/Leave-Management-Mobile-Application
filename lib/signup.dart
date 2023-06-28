import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = '';

  Future save() async {
    var response = await http.post(
        "http://192.168.80.1:3001/api/users/register",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'name': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'passwordConfirm': _confirmPasswordController.text,
          },
        ));
    print(response.body);
    if (response.statusCode == 201) {
      // Successful signup
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Signin()));
    } else {
      // Signup failed
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
        duration: Duration(seconds: 1),
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
            top: 100,
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
                  height: 230,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Signup",
                    style: GoogleFonts.pacifico(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.orange),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 80,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _nameController.text = value;
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          _showSnackBar('Enter Name');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.man,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Name',
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => _emailController.text = value,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          _showSnackBar('Enter Email');
                        } else if (RegExp(
                                r"^[a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
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
                      obscureText: true,
                      onSaved: (value) => _passwordController.text = value,
                      validator: (value) {
                        if (value.isEmpty) {
                          _showSnackBar('Enter Password');
                        }
                        return null;
                      },
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
                  height: 80,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      onSaved: (value) =>
                          _confirmPasswordController.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _showSnackBar(' confirm your password');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          hintText: 'Confirm Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 143, 142, 142))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
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
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState?.save();
                            save();
                            print("button pressed");
                            print("name" + _nameController.text);
                            print("email" + _emailController.text);
                            print("password" + _passwordController.text);
                            print("confirmPassword" +
                                _confirmPasswordController.text);
                          } else {
                            print("Something went wrong");
                          }
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
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
                              "Already have an Account ? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Signin()));
                              },
                              child: Text(
                                "Signin",
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

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text('This is an alert message.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
