import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/report.dart';
import 'package:frontend/roster.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;

import 'dashboard.dart';
import 'leave.dart';

class MyCheckin extends StatefulWidget {
  const MyCheckin({Key key, this.responseData}) : super(key: key);
  final responseData;

  @override
  State<MyCheckin> createState() => _MyCheckinState();
}

class _MyCheckinState extends State<MyCheckin> {
  var isTick = false;
  var isCheckedIn = false;
  var buttonText = "Check-In";
  var timeText = "Time";
  bool shouldDisplayContainer = true;

  var selectedDate;
  var checkInTime;
  var checkOutTime;

  var showTime;

  void checkBox() {
    setState(() {
      isTick = !isTick;
    });
  }

  String getTime() {
    return DateFormat('HH:mm').format(
        DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30)));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void handleCheckInOut() {
    setState(() {
      if (isCheckedIn) {
        // Check-Out
        shouldDisplayContainer = true;
        timeText = "Time";
        buttonText = "Check-In";
        isCheckedIn = false;
        showTime = getTime();
        checkInTime = getTime();
        sendCheckOutRequest();
      } else {
        // Check-In
        shouldDisplayContainer = false;
        timeText = "Checked-In Time";
        buttonText = "Check-Out";
        isCheckedIn = true;
        checkInTime = getTime();
        showTime = checkInTime;
        sendCheckInRequest();
      }
    });
  }

  Future sendCheckInRequest() async {
    print("Save Pressed");
    var response2 = await http.post("http://192.168.80.1:3001/api/roster",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'id': widget.responseData['data']['user']['_id'],
            'name': widget.responseData['data']['user']['name'],
            'email': widget.responseData['data']['user']['email'],
          },
        ));
    print(response2);
    _showSnackBar(
        "Checked In Successfully!", context, Color.fromARGB(255, 9, 187, 6));
  }

  Future sendCheckOutRequest() async {
    var id = widget.responseData['data']['user']['empID'];
    print("Save Pressed");
    var response3 = await http.post(
        "http://192.168.80.1:3001/api/roster/update/${id}",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'id': widget.responseData['data']['user']['_id'],
            'name': widget.responseData['data']['user']['name'],
            'email': widget.responseData['data']['user']['email'],
            'checkInTime': checkInTime,
            'checkOutTime': checkOutTime,
          },
        ));
    print(response3);
    _showSnackBar(
        "Checked Out Successfully!", context, Color.fromARGB(255, 9, 187, 6));
  }

  Widget profile(final res) {
    var showTime = getTime();

    return Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            backgroundColor: Color.fromARGB(
                255, 248, 248, 248), // Customize the button color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Customize the button shape
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 2, 0, 15),
                child: SizedBox(
                  child: Text(
                    res['data']['user']
                        ['jobTitle'], // Replace with your button text
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight:
                            FontWeight.bold), // Customize the text style
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0, top: 30.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40.0, bottom: 10),
                          child: Text(
                            "Employee ID  : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40.0, bottom: 10),
                          child: Text(
                            "${timeText} : ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (shouldDisplayContainer)
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 10, left: 10, top: 10),
                            child: Text(
                              "Working From Home  : ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 14, top: 0),
                          child: Text(
                            res['data']['user']['empID'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            showTime,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (shouldDisplayContainer)
                          Container(
                              // width: 200.0,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  CheckboxTheme(
                                    data: CheckboxThemeData(
                                      visualDensity: VisualDensity
                                          .compact, // Reduce the overall density
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Container(
                                      child: Checkbox(
                                        value: isTick,
                                        onChanged: (newValue) {
                                          checkBox();
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    onPressed: () {
                      handleCheckInOut();
                    },
                    child: Container(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
        decoration: myShadow());
  }

  Widget myrecords() {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 100),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            backgroundColor: Color.fromARGB(
                255, 248, 248, 248), // Customize the button color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Customize the button shape
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 40),
                child: SizedBox(
                  child: Text(
                    'My Records', // Replace with your button text
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),

                    // Customize the text style
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 16.0),
                        Text(
                          selectedDate != null
                              ? dateFormatter.format(selectedDate)
                              : 'Select a date',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.all(7),
                    child: Text(
                      "Check",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20.0, top: 40.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 100.0, bottom: 10),
                          child: Text(
                            "Total Hours  : ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            " ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: myShadow());
  }

  @override
  Widget build(BuildContext context) {
    final res = widget.responseData;
    return Scaffold(
        appBar: myAppBar(context, res),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              // color: Color.fromARGB(255, 223, 222, 222),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [profile(res), myrecords()],
              )),
        ));
  }
}

PreferredSizeWidget myAppBar(BuildContext context, res) {
  return AppBar(
    title: const Text("Check-in & Check-out"), //sets the appbar
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        // Show the dropdown menu
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(0, kToolbarHeight, 0, 0),
          items: [
            PopupMenuItem(
              child: Text('Dashobard'),
              value: 5,
            ),
            PopupMenuItem(
              child: Text('My Roster'),
              value: 1,
            ),
            PopupMenuItem(
              child: Text('My Leave'),
              value: 2,
            ),
            PopupMenuItem(
              child: Text('Check-in & Checkout'),
              value: 3,
            ),
            PopupMenuItem(
              child: Text('Monthly Report'),
              value: 4,
            ),
          ],
          elevation: 8.0,
        ).then((value) {
          // Handle the selected menu item
          if (value == 1) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => MyRoster(res)));
          } else if (value == 2) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => MyLeave(
                          response: res,
                        )));
          } else if (value == 3) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => MyCheckin(
                          responseData: res,
                        )));
          } else if (value == 4) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => MyReport(
                          responseData: res,
                        )));
          } else if (value == 5) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => Dashboard(
                          responseData: res,
                        )));
          }
        });
      },
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_vert),
      ),
    ],
    backgroundColor: Color.fromARGB(255, 40, 87, 41),
  );
}

BoxDecoration myShadow() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 107, 106, 106)
            .withOpacity(0.3), // Customize the shadow color
        spreadRadius: 2, // Customize the spread radius
        blurRadius: 20, // Customize the blur radius
        offset: Offset(3, 5), // Customize the shadow position
      ),
    ],
  );
}

void _showSnackBar(String message, BuildContext context, clr) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior
          .floating, // Make the SnackBar float above the content
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Add rounded corners to the SnackBar
      ),
      backgroundColor: clr, // Set the background color of the SnackBar
      // contentTextStyle: TextStyle(color: Colors.white), // Set the text color of the SnackBar content
      elevation: 4, // Set the duration for which the SnackBar should be visible
    ),
  );
}
