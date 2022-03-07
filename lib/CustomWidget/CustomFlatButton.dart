import 'dart:io';

import 'package:FitnessPlace/Constant/FitnessConstant.dart';
import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String txt;
  final Function fun;
  final Color color;
  final Color fontColor;
  final double fontsize;

  const CustomFlatButton(
      {Key key, this.txt, this.fun, this.color, this.fontColor, this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = fontsize != null
        ? fontsize
        : SizeConfig.textMultiplier <= 7.36
            ? 19
            : SizeConfig.textMultiplier <= 8.96 ? 20 : 35;

    final style = TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: fontColor == null ? Colors.white : fontColor,
      // padding: EdgeInsets.all(10),
    );
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(txt, style: style),
            onPressed: fun,
            color: color == null ? FitnessConstant.appBarColor : color,
            //color: Colors.cyan,
            padding: EdgeInsets.all(0),
          )
        : FlatButton(
            child: Text(txt, style: style),
            onPressed: fun,
            color: FitnessConstant.appBarColor,
          );
  }
}
