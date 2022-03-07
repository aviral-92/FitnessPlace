import 'package:FitnessPlace/Constant/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar {
  final String txt;
  final Color txtColor;
  final bool isBackButtonReq;
  final Color bgColor;
  final bool isIconRequired;
  final IconData iconData;
  final Function fun;
  final bool transitionBetweenRoutes;
  final Widget w;

  CustomNavigationBar({
    this.txt,
    this.txtColor,
    this.isBackButtonReq,
    this.bgColor,
    this.isIconRequired,
    this.iconData,
    this.fun,
    this.transitionBetweenRoutes,
    this.w,
  });

  CupertinoNavigationBar getCupertinoNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text(
        txt,
        style: TextStyle(color: txtColor),
      ),
      backgroundColor: bgColor,
      actionsForegroundColor: txtColor,
      automaticallyImplyLeading: isBackButtonReq,
      trailing: isIconRequired == null || !isIconRequired
          ? SizedBox()
          : GestureDetector(
              child: Container(
                child:
                    w, /*Icon(
                  iconData,
                  color: txtColor,
                ),*/
              ),
              onTap: fun,
            ),
      transitionBetweenRoutes:
          transitionBetweenRoutes == null ? true : transitionBetweenRoutes,
    );
  }

  Widget getAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: bgColor,
        toolbarHeight: 6.74 * SizeConfig.heightMultiplier,
        title: Text(
          txt,
          style: TextStyle(
              color: Colors.white,
              fontSize: 3.29 * SizeConfig.heightMultiplier),
        ),
        automaticallyImplyLeading: isBackButtonReq,
        //leading: Text('kckc'),
        actions: isIconRequired == null || !isIconRequired
            ? [SizedBox()]
            : [
                GestureDetector(
                  child: Container(
                    child: Icon(
                      iconData,
                      color: txtColor,
                    ),
                  ),
                  onTap: fun,
                )
              ],
      );
}
