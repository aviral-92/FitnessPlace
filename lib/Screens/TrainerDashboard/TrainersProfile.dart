import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Modal/Profile.dart';
import 'package:FitnessPlace/Modal/User.dart';
import 'package:FitnessPlace/Repository/ProfileRepository.dart';
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
  //String picturePath = '';

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
      /*setState(() {
        picturePath = value.picturePath;
      });*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /*Center(
            child: picturePath.isNotEmpty
                ? CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(picturePath),
                    //child: Icon(Icons.video_call),
                  )
                : CircularProgressIndicator(),
          ),*/
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
