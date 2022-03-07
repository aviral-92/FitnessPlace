import 'dart:io';

import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/CustomWidget/CustomTextField.dart';
import 'package:FitnessPlace/Modal/Profile.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Networking/ApiBaseHelper.dart';
import 'package:FitnessPlace/Repository/ClassScheduleRepository.dart';
import 'package:FitnessPlace/Repository/ProfileRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainersProfile extends StatefulWidget {
  @override
  _TrainersProfileState createState() => _TrainersProfileState();
}

class _TrainersProfileState extends State<TrainersProfile> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController specialityController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    ProfileRepository profileRepository = new ProfileRepository();
    final response = profileRepository.getProfileByUsername(null, context);
    response.then((value) {
      nameController.text = value.name;
      mobileController.text = value.mobile;
      dobController.text = value.dob;
      specialityController.text = value.speciality;
      genderController.text = value.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CustomNavigationBar customNavigationBar = new CustomNavigationBar(
        bgColor: FitnessConstant.appBarColor,
        isBackButtonReq: false,
        isIconRequired: true,
        txt: 'Profile',
        txtColor: Colors.white,
        w: GestureDetector(
          child: Icon(Icons.add_to_home_screen),
          onTap: () {
            if (Platform.isAndroid) {
              ClassScheduleRepository classScheduleRepository =
                  new ClassScheduleRepository();
              classScheduleRepository.logout(context);
            } else {
              ApiBaseHelper _api = new ApiBaseHelper();
              _api.flush();
              Navigator.of(context, rootNavigator: true).pop();
            }
            /**/
          },
        ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: customNavigationBar.getCupertinoNavigationBar(),
            child: getPgaeBody())
        : getPgaeBody();
  }

  Widget getPgaeBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          getContainer('Name', nameController),
          getContainer('Gender', genderController),
          getContainer('Mobile', mobileController),
          getContainer('DOB', dobController),
          getContainer('Speaciality', specialityController),
          RaisedButton(
            color: Colors.deepPurple[900].withOpacity(0.9),
            child: Text(
              'UPDATE',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              ProfileRepository profileRepository = new ProfileRepository();
              User user = new User();
              Profile profile = new Profile();
              profile.dob = dobController.text;
              profile.gender = genderController.text;
              profile.name = nameController.text;
              profile.mobile = mobileController.text;
              profile.speciality = specialityController.text;
              user.profile = profile;
              final response = profileRepository.updateProfile(user, context);
              response.then((value) {
                if (value != null) {
                  ConstantWidgets.showMaterialDialog(
                      context, 'Successfully Updated !!', 'Success');
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget getContainer(String txt, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 10,
      ),
      child: Container(
        width: double.infinity,
        child: CustomTextField(
          hintTxt: txt,
          controller: controller,
          obscure: false,
          mode: OverlayVisibilityMode.editing,
        ),

        /*TextField(
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
              fillColor: Colors.black,
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: new BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: txt,
              labelText: txt),
          controller: controller,
        ),*/
      ),
    );
  }
}
