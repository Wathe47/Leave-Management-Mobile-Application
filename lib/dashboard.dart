import 'package:flutter/material.dart';
import 'package:frontend/leave.dart';
import 'package:frontend/report.dart';
import 'package:frontend/roster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/signup.dart';
import 'package:frontend/checkin.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/user.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.responseData}) : super(key: key);
  final responseData;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final res = widget.responseData;
    return Scaffold(
        appBar: myAppBar(context, res),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              // color: Color.fromARGB(255, 223, 222, 222),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profile(res),
                  checkinBox(context, res),
                  leaveBox(context, res),
                  rosterBox(context, res),
                  reportBox(context, res),
                  SizedBox(
                    height: 200.0,
                  ),
                ],
              )),
        ));
  }
}

Widget profile(final res) {
  return Container(
      margin: EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          backgroundColor:
              Color.fromARGB(255, 248, 248, 248), // Customize the button color
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Customize the button shape
          ),
        ),
        child: Column(
          children: [
            Container(
              child: SizedBox(
                child: Text(
                  res['data']['user']['name'], // Replace with your button text
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  // Customize the text style
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 2, 0, 15),
              child: SizedBox(
                child: Text(
                  res['data']['user']
                      ['jobTitle'], // Replace with your button text
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black), // Customize the text style
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: CircleAvatar(
                  radius:
                      60.0, // Adjust the radius to control the size of the image
                  backgroundImage: AssetImage(
                      'images/6.jpg'), // Replace with your image path
                )),
            Container(
              margin: EdgeInsets.only(bottom: 20.0, top: 30.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40.0),
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
                        child: Text(
                          "Email  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Status  : ",
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
                        child: Text(
                          res['data']['user']['empID'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text(
                          res['data']['user']['email'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          res['data']['user']['active']
                              ? 'Active'
                              : 'Not working',
                          style: TextStyle(
                            color: res['data']['user']['active']
                                ? Colors.green
                                : Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      decoration: myShadow());
}

Widget checkinBox(BuildContext context, res) {
  return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
      height: 100.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
                255, 248, 248, 248), // Customize the button color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Customize the button shape
            ),
            padding: EdgeInsets.all(0.0)),
        child: GestureDetector(
          onTap: () {
            // Handle button tap
            print("pressed");
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => MyCheckin(
                    responseData: res,
                  ),
                ));
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(15.0), // Apply border radius to image
            child: Stack(
              children: [
                Image.asset(
                  'images/checkin.jpeg', // Replace with your background image path
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 8, 3, 78).withOpacity(
                        0.7), // Customize the overlay color and opacity
                    borderRadius: BorderRadius.circular(
                        10.0), // Apply border radius to the overlay
                  ),
                ),
                Center(
                  child: Text(
                    'Check-in & Check-out',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: myShadow());
}

Widget leaveBox(BuildContext context, final res) {
  return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
      height: 100.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
                255, 248, 248, 248), // Customize the button color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Customize the button shape
            ),
            padding: EdgeInsets.all(0.0)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => MyLeave(
                    response: res,
                  ),
                ));
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(15.0), // Apply border radius to image
            child: Stack(
              children: [
                Image.asset(
                  'images/leave.png', // Replace with your background image path
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 99, 2, 6).withOpacity(
                        0.7), // Customize the overlay color and opacity
                    borderRadius: BorderRadius.circular(
                        10.0), // Apply border radius to the overlay
                  ),
                ),
                Center(
                  child: Text(
                    'Requesting Leave',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: myShadow());
}

Widget rosterBox(BuildContext context, final res) {
  return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
      height: 100.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
                255, 248, 248, 248), // Customize the button color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Customize the button shape
            ),
            padding: EdgeInsets.all(0.0)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => MyRoster(res),
                ));
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(15.0), // Apply border radius to image
            child: Stack(
              children: [
                Image.asset(
                  'images/roster.png', // Replace with your background image path
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 37, 37, 37).withOpacity(
                        0.7), // Customize the overlay color and opacity
                    borderRadius: BorderRadius.circular(
                        10.0), // Apply border radius to the overlay
                  ),
                ),
                Center(
                  child: Text(
                    'My Working Roster',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: myShadow());
}

Widget reportBox(BuildContext context, final res) {
  return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
      height: 100.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
                255, 248, 248, 248), // Customize the button color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Customize the button shape
            ),
            padding: EdgeInsets.all(0.0)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => MyReport(
                    responseData: res,
                  ),
                ));
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(15.0), // Apply border radius to image
            child: Stack(
              children: [
                Image.asset(
                  'images/reports.jpg', // Replace with your background image path
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 37, 78, 106).withOpacity(
                        0.7), // Customize the overlay color and opacity
                    borderRadius: BorderRadius.circular(
                        10.0), // Apply border radius to the overlay
                  ),
                ),
                Center(
                  child: Text(
                    'My Monthly Report',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: myShadow());
}

PreferredSizeWidget myAppBar(BuildContext context, res) {
  return AppBar(
    title: const Text("Dashboard"), //sets the appbar
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
        color: Color.fromARGB(255, 4, 4, 4)
            .withOpacity(0.5), // Customize the shadow color
        spreadRadius: 2, // Customize the spread radius
        blurRadius: 20, // Customize the blur radius
        offset: Offset(3, 5), // Customize the shadow position
      ),
    ],
  );
}

Widget styledText() {
  return RichText(
    text: TextSpan(
      text: 'This is the ',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: 'styled portion',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: ' of the text.',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
