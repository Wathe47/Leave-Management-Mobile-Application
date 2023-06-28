import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/roster.dart';

import 'checkin.dart';
import 'leave.dart';

class MyReport extends StatefulWidget {
  const MyReport({Key key, this.responseData}) : super(key: key);
  final responseData;
  @override
  State<MyReport> createState() => _MyReportState();
}

class _MyReportState extends State<MyReport> {
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
                  SizedBox(
                    height: 400.0,
                  ),
                ],
              )),
        ));
  }
}

Widget profile(final res) {
  return Container(
      margin: EdgeInsets.fromLTRB(35, 70, 35, 10),
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10.0),
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
              margin: EdgeInsets.all(10),
              child: SizedBox(
                child: Text(
                  'Monthly Report', // Replace with your button text
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
                  'June 2023', // Replace with your button text
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black), // Customize the text style
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
                        margin: EdgeInsets.only(left: 40.0),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Name : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.0),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Employee ID  : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Job Role  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Phone No  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Working Hours  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Overtime Hours  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Leave Count  : ",
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          res['data']['user']['name'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          res['data']['user']['empID'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          res['data']['user']['email'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "076 911 7815",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                        child: Text(
                          "150",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                        child: Text(
                          "20",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                        child: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
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

PreferredSizeWidget myAppBar(BuildContext context, res) {
  return AppBar(
    title: const Text("My Reports"), //sets the appbar
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
