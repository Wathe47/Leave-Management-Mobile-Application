import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/report.dart';
import 'package:frontend/roster.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'checkin.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;

class MyLeave extends StatefulWidget {
  const MyLeave({Key key, this.response}) : super(key: key);
  final response;
  @override
  State<MyLeave> createState() => _MyLeaveState();
}

class _MyLeaveState extends State<MyLeave> {
  var selectedStartDate = null;
  var selectedEndDate = null;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _startDateController;

  TextEditingController _endDateController;

  TextEditingController _priorityController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController(
      text: selectedStartDate != null
          ? dateFormatter.format(selectedStartDate)
          : '',
    );
    _endDateController = TextEditingController(
      text:
          selectedEndDate != null ? dateFormatter.format(selectedEndDate) : '',
    );
  }

  Future save() async {
    print(_nameController.text);
    print(_startDateController.text);
    print(_endDateController.text);
    print(_priorityController.text);
    var response = await http.post("http://192.168.80.1:3001/api/leaves",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'id': widget.response['data']['user']['_id'],
            'date': _startDateController.text,
            'type': _priorityController.text,
            'reason': _commentsController.text,
          },
        ));

    print(response);
    _showSnackBar("Leave Submitted Successfully!", context,
        Color.fromARGB(255, 9, 187, 6));

    _formKey.currentState.reset();
    _nameController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _priorityController.clear();
    _commentsController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _priorityController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        _startDateController.text = dateFormatter.format(picked).toString();
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        _endDateController.text = dateFormatter.format(picked).toString();
      });
    }
  }

  Widget leaveRequestForm() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 50),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Leave Request',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onSaved: (newValue) => _nameController.text = newValue,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    _selectStartDate(context);
                  },
                  readOnly: true, // Prevents manual text input
                  controller: _startDateController,
                  onSaved: (newValue) {
                    _startDateController.text = newValue.toString();
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    _selectEndDate(context);
                  },
                  readOnly: true, // Prevents manual text input
                  controller: _endDateController,
                  onSaved: (newValue) {
                    _endDateController.text = newValue.toString();
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Reason',
                  ),
                  value: null,
                  items: ['Vacational', 'Sick', 'maternity ', 'other']
                      .map((priority) => DropdownMenuItem<String>(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (selectedPriority) {},
                  onSaved: (newValue) => _priorityController.text = newValue,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Comments',
                  ),
                  maxLines: 3,
                  onSaved: (newValue) => _commentsController.text = newValue,
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      onPressed: () {
                        // print("object");
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          save();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        decoration: myShadow());
  }

  Widget leaveSummery() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                margin: EdgeInsets.fromLTRB(0, 12, 0, 15),
                child: SizedBox(
                  child: Text(
                    'Summery of Leaves', // Replace with your button text
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
                            "Pending Requests  : ",
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
                            "Approved Requests  : ",
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
                          margin: EdgeInsets.only(bottom: 12, top: 0),
                          child: Text(
                            "5",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "10",
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
              ),
            ],
          ),
        ),
        decoration: myShadow());
  }

  @override
  Widget build(BuildContext context) {
    final res = widget.response;

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
                children: [
                  leaveRequestForm(),
                  leaveSummery(),
                  SizedBox(
                    height: 50,
                  )
                ],
              )),
        ));
  }
}

PreferredSizeWidget myAppBar(BuildContext context, res) {
  return AppBar(
    title: const Text("My leave"), //sets the appbar
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
