import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Screens/AdminDashboard/Schedule/AddSchedule.dart';
import 'package:flutter/material.dart';

class ScheduleHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                elevation: 12,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSchedule(),
                    ),
                  );
                },
                child: Text(
                  'Add Schedule',
                  style: TextStyle(
                      fontSize: 20, color: FitnessConstant.appBarColor),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                elevation: 12,
                onPressed: null,
                child: Text(
                  'View Schedule',
                  style: TextStyle(
                      fontSize: 20, color: FitnessConstant.appBarColor),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                elevation: 12,
                onPressed: null,
                child: Text(
                  'Update Schedule',
                  style: TextStyle(
                      fontSize: 20, color: FitnessConstant.appBarColor),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                elevation: 12,
                onPressed: null,
                child: Text(
                  'Delete Schedule',
                  style: TextStyle(
                      fontSize: 20, color: FitnessConstant.appBarColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
