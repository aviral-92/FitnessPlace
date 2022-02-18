import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Modal/Role.dart';
import 'package:FitnessPlace/Service/RoleService.dart';
import 'package:flutter/material.dart';

class ChangeRole extends StatefulWidget {
  @override
  _ChangeRoleState createState() => _ChangeRoleState();
}

class _ChangeRoleState extends State<ChangeRole> {
  List<Role> roleList = new List();
  TextEditingController controller = new TextEditingController();
  String val = 'Select the value';
  RoleService roleService = new RoleService();

  void initState() {
    final response = roleService.findAll(context);
    response.then((list) {
      setState(() {
        roleList = list;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(roleList);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 20,
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
                    hintText: 'Username',
                    labelText: 'Username'),
                controller: controller,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 20,
            ),
            child: Container(
              width: double.infinity,
              child: DropdownButton<String>(
                items: roleList.map((Role role) {
                  return DropdownMenuItem<String>(
                    value: role.role,
                    child: Text(role.role),
                  );
                }).toList(),
                hint: Text(val),
                onChanged: (changedValue) {
                  print(changedValue);
                  setState(() {
                    val = changedValue;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: RaisedButton(
              color: FitnessConstant.appBarColor,
              onPressed: () {
                Role role;
                roleList.forEach((element) {
                  if (element.role == val) role = element;
                });
                print(role);
                final response =
                    roleService.changeRole(context, controller.text, role);
                response.then((value) {
                  if (value != null) {
                    ConstantWidgets.showMaterialDialog(
                        context,
                        'Succussfully changed the role for ${controller.text}',
                        'Successfully updated!');
                  }
                }).catchError((onError) {
                  print(onError);
                  ConstantWidgets.showMaterialDialog(
                      context,
                      'unable to change the role for ${controller.text}',
                      'Unable to update!');
                });
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
