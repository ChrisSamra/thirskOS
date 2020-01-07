/// This file contains common widgets that are being used throughout the application.
/// 
/// Widgets appeared in this file are very general and are not limited to a single function of the app.

import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';

/// A button that navigates between home, thrive, and event pages. Displays on the bottom of the app.
/// 
/// Chris decided he wants to make 3 classes for something with the same functionality for some reason. 
/// I helped him by combine three same class into one. Useful if we decide to make more pages.
class NavigationButton extends StatelessWidget{
  final String buttonImage;
  final String buttonText;

  NavigationButton({Key key, @required this.buttonImage, @required this.buttonText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container( child: Column(
      children: <Widget>[

        new Image(image: new AssetImage(buttonImage), height: 34, width: 34,),
        new Text(buttonText,
          style: new TextStyle(
              fontSize: 10,
              fontFamily: 'LEMONMILKLIGHT',
              letterSpacing: 2,
              fontStyle: FontStyle.italic
          ),
        ),

      ],
    ));

  }
}
///The button widget for linking to resources in [ThrivePage].
class ThriveButton extends StatelessWidget{
  /// The text to be displayed on the button.
  final String buttonName;
  /// The child widget inside this button if not null.
  /// 
  /// If both this variable and [buttonName] are specified, this variable is used instead.
  final Widget child;
  /// The color to be filled in the button.
  final Color fillColor;
  /// Action to take when the button is pressed.
  final Function onPressed;

  ThriveButton({
    Key key,
    this.buttonName,
    this.child,
    this.fillColor,
    @required this.onPressed,
  }) : super(key: key){
    if(buttonName == null && child == null){
      throw ArgumentError("Error: buttonName or child must be specified.");
    }
  }
  @override
  Widget build(BuildContext context){
    return new RawMaterialButton(  //creates button
      child: child ?? Text(
        buttonName,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'LEMONMILKLIGHT',
          fontSize: 18,
          letterSpacing: 4
        ),
      ),
      shape: StadiumBorder(), //style & shape of button
      highlightColor: Color(0x0083ff), //dw about this
      padding: EdgeInsets.all(10), //space between edge of button and text
      fillColor: fillColor ?? Colors.grey, //button colour
      splashColor: Colors.white, //colour of button when tapped

      onPressed: onPressed,
    );
  }
}
///A class to store data for the links to a resource in [ThrivePage].
class ThriveButtonData{
  String name;
  Function clickAction;
  ThriveButtonData(this.name,this.clickAction);
}
/// A button when pressed, returns to the previous page. Should be included in all subpages.
class PreviousPageButton extends StatelessWidget{
  final String text;
  PreviousPageButton({Key key, this.text}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Text(text ?? getString('misc/back'), style: TextStyle(color: Colors.white, fontSize: 18,),),
      shape: StadiumBorder(),
      highlightColor: Color(0x0083ff),
      padding: EdgeInsets.all(5),
      fillColor: Colors.black12,
      splashColor: Colors.white,

      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}