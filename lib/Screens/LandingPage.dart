import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:FitnessPlace/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.scaleFactor);
    return SafeArea(
      bottom: false,
      top: false,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.yellow[100],
                Colors.brown[400],
                Colors.indigo,
                Colors.teal,
                Colors.white,
              ]),
          image: DecorationImage(
            image: AssetImage('assets/img/IMG_0118.JPG'),
            fit: BoxFit.contain,
          ),
        ),
        padding: EdgeInsets.only(top: 3.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/logo.jpeg'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            /*Image(
              image: AssetImage('assets/img/logo.jpeg'),
              filterQuality: FilterQuality.high,
            ),*/
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Colors.grey, width: 3),
              ),
              child: Text(
                'Lets get started ',
                style: GoogleFonts.italianno(
                  color: Colors.white.withOpacity(1),
                  fontSize: SizeConfig.scaleFactor * 7, //55.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
