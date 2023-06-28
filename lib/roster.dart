import 'package:flutter/material.dart';
import 'package:frontend/checkin.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/leave.dart';
import 'package:frontend/report.dart';

class MyRoster extends StatelessWidget {
  MyRoster(this.res);
  final res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, res),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildRosterDay(index, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRosterDay(int index, BuildContext context) {
    final dayOfWeek =
        DateTime.now().add(Duration(days: index)).toLocal().weekday;
    final dayName = _getDayName(dayOfWeek);
    final shift = _getShift(dayOfWeek);

    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 107, 106, 106).withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 20,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.orange,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 251, 151, 1),
                borderRadius: BorderRadius.circular(20.0)),
            padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
            child: Column(
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Text(
                  shift,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Job/Task:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  _showTaskDetails(context);
                },
                icon: Icon(Icons.work),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assigned Employees:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  // Handle edit button press
                },
                icon: Icon(Icons.people),
              ),
            ],
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildEmployeeAvatar(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeAvatar(int index) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[200],
        child: Text(
          'E${index + 1}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      default:
        return '';
    }
  }

  String _getShift(int dayOfWeek) {
    switch (dayOfWeek) {
      case DateTime.monday:
        return 'Day Shift';
      case DateTime.tuesday:
        return 'Night Shift';
      case DateTime.wednesday:
        return 'Evening Shift';
      case DateTime.thursday:
        return 'Day Shift';
      case DateTime.friday:
        return 'Night Shift';
      default:
        return '';
    }
  }
}

PreferredSizeWidget myAppBar(BuildContext context, res) {
  return AppBar(
    title: const Text("My Roster"), //sets the appbar
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

void _showTaskDetails(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 25, 172, 62).withOpacity(0.2),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Task Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Task Name: Task 1',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),

              SizedBox(height: 8.0),
              // Add more details or actions related to the task here
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.orange, // Set the background color of the button
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
