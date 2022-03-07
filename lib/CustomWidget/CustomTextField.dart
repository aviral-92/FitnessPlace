import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintTxt;
  final String labelTxt;
  final TextInputType inputType;
  final bool obscure;
  final Function fun;
  final int minLines;
  final int maxLines;
  final Icon icon;
  final bool isReadOnly;
  final OverlayVisibilityMode mode;

  const CustomTextField({
    Key key,
    this.controller,
    this.hintTxt,
    this.labelTxt,
    this.inputType,
    this.obscure,
    this.fun,
    this.minLines,
    this.maxLines,
    this.icon,
    this.isReadOnly,
    this.mode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //print(fun);
    return Platform.isIOS
        ? CupertinoTextField(
            style: TextStyle(
              fontSize: 2.44 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.bold,
            ),
            placeholder: hintTxt,
            obscureText: obscure,
            controller: controller,
            enabled: true,
            keyboardType: inputType,
            minLines: minLines != null ? minLines : 1,
            maxLines: maxLines != null ? maxLines : 1,
            onTap: fun != null ? fun : () {},
            //suffix: icon != null ? icon : SizedBox(),
            prefix: icon != null ? icon : SizedBox(),
            clearButtonMode: mode,
            placeholderStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
            readOnly: isReadOnly != null ? isReadOnly : false,
            decoration: BoxDecoration(
              border: Border.all(color: FitnessConstant.appBarColor),
            ),
          )
        : TextField(
            style: TextStyle(fontSize: 2.44 * SizeConfig.textMultiplier),
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderSide: new BorderSide(
                  color: Colors.teal,
                ),
              ),
              hintText: hintTxt,
              labelText: labelTxt,
              isDense: true,
            ),
            controller: controller,
            enabled: isReadOnly != null ? !isReadOnly : true,
            keyboardType: inputType,
            obscureText: obscure,
            minLines: minLines != null ? minLines : 1,
            maxLines: maxLines != null ? maxLines : 1,
            onTap: fun != null ? fun : () {},
          );
  }
}
