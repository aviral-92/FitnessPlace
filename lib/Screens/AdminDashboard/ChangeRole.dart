import 'dart:io';

import 'package:FitnessPlace/Constant/ConstantWidgets.dart';
import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/CustomWidget/CustomNavigationBar.dart';
import 'package:FitnessPlace/CustomWidget/CustomTextField.dart';
import 'package:FitnessPlace/Modal/Role.dart';
import 'package:FitnessPlace/Service/RoleService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeRole extends StatefulWidget {
  @override
  _ChangeRoleState createState() => _ChangeRoleState();
}

class _ChangeRoleState extends State<ChangeRole> {
  List<Role> roleList = new List();
  TextEditingController controller = new TextEditingController();
  TextEditingController controllerRole = new TextEditingController();
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

  CustomNavigationBar customNavigationBar = new CustomNavigationBar(
    bgColor: FitnessConstant.appBarColor,
    txt: 'Change Role',
    txtColor: Colors.white,
    isBackButtonReq: false,
    isIconRequired: false,
  );

  @override
  Widget build(BuildContext context) {
    //print(roleList);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: customNavigationBar.getCupertinoNavigationBar(),
            child: pageBody(),
          )
        : pageBody();
  }

  Widget pageBody() {
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
              child: CustomTextField(
                hintTxt: 'Username',
                obscure: false,
                controller: controller,
                mode: OverlayVisibilityMode.editing,
                //fun: () => _forIOS(controller),
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
                    hintText: 'Username',
                    labelText: 'Username'),
                controller: controller,
              ),*/
            ),
          ),
          Platform.isAndroid
              ? Padding(
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
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: Container(
                    width: double.infinity,
                    child: CustomTextField(
                      hintTxt: 'Roles',
                      obscure: false,
                      isReadOnly: true,
                      controller: controllerRole,
                      mode: OverlayVisibilityMode.editing,
                      fun: () => _forIOS(controllerRole),
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

  void _forIOS(TextEditingController controller) {
    List<Text> roleItems = new List();
    roleList.forEach((role) {
      roleItems.add(Text(role.role));
    });
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoPicker(
              children: roleItems,
              onSelectedItemChanged: (value) {
                Text text = roleItems[value];
                setState(() {
                  controller.text = text.data;
                });
              },
              itemExtent: 25,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.2,
            ),
          );
        });
  }
}
