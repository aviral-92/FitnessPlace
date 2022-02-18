/*import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Screens/UserDashboard/ClassScheduleScreen.dart';
import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //color: Colors.blue,
              height: 40,
              child: Center(
                child: Text(
                  'Trainers',
                  style: FitnessConstant.leckerliOneGoogleFont(),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 140,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 0),
                child: Card(
                  elevation: 16,
                  child: ListView.separated(
                    itemCount: 5,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (_, i) => sampleAvatar(),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Row(
                children: [
                  Text(
                    'Classes',
                    style: FitnessConstant.leckerliOneGoogleFont(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: Container(
                height: 570,
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  child: ListView.separated(
                    itemCount: 7,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemBuilder: (_, i) => getRow(context),
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 70,
          height: 70,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: CircleAvatar(
            //radius: 20,
            backgroundImage: NetworkImage(
                'https://www.pinclipart.com/picdir/middle/499-4992513_avatar-avatar-png-clipart.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TRX',
                style: FitnessConstant.tauriGoogleFont(),
              ),
              Text(
                'with Samantha',
                style: FitnessConstant.tauriGoogleFontSize(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClassScheduleScreen(),
              )),
          child: Icon(
            Icons.arrow_right,
            size: 50,
            color: Colors.deepPurple[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget sampleAvatar() {
    return Column(
      children: [
        Container(
          width: 85.0,
          height: 88.0,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.nj.com/resizer/zovGSasCaR41h_yUGYHXbVTQW2A=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg'),
          ),
        ),
        Text(
          'Avatar Avatar',
          style: FitnessConstant.tauriGoogleFontSize(),
        ),
      ],
    );
  }
}
*/
