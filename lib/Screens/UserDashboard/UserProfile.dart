import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:FitnessPlace/Modal/Profile.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Repository/ProfileRepository.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    ProfileRepository profileRepository = new ProfileRepository();
    final response = profileRepository.getProfileByUsername(null, context);
    response.then((value) {
      nameController.text = value.name;
      mobileController.text = value.mobile;
      dobController.text = value.dob;
      genderController.text = value.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('SizeConfig.blockSizeHorizontal=>${SizeConfig.blockSizeHorizontal}');
    print('SizeConfig.blockSizeVertical=>${SizeConfig.blockSizeVertical}');
    return Column(
      children: [
        getContainer('Name', nameController),
        getContainer('Gender', genderController),
        getContainer('Mobile', mobileController),
        getContainer('DOB', dobController),
        getContainer('Height in Feets', heightController),
        getContainer('Weight in LBs', weightController),
        //getContainer('Speaciality', specialityController),
        RaisedButton(
          color: Colors.deepPurple[900].withOpacity(0.9),
          child: Text(
            'UPDATE',
            style: TextStyle(
              fontSize: 4.34 * SizeConfig.safeBlockHorizontal, //18,
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
            //profile.speciality = specialityController.text;
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
        child: TextField(
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
        ),
      ),
    );
  }
}
