/// This file defines many functions and classes that are used throughout the application.

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
///Link to a url. Opens as a web page for some reason.
Future launchURL(String url) async {
  if (await canLaunch(url)){
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print("Fail to launch $url.");
  }

}
///A simple command to go to a page in the app.
void goToPage(BuildContext context,Widget page){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page), //goes to built in page when button pressed
  );
}
///Returns the minute value for [timeOfDay]
int timeOfDayToInt(TimeOfDay timeOfDay){
  return timeOfDay.hour * TimeOfDay.minutesPerHour + timeOfDay.minute;
}
/// Calculate the difference between [a] and [b].
///
/// If [a] is later than [b], the value is positive; otherwise, it's negative.
int timeOfDayDifference(TimeOfDay a, TimeOfDay b){
  return timeOfDayToInt(a) - timeOfDayToInt(b);
}

/// An interface for objects that can be cloned, either a shallow copy or a deep copy.
/// 
/// For some reason, flutter does not have this as one of its default functions.
abstract class Cloneable{
  /// Clones an object. Returns a new object with values identicle to the object that this is called on.
  /// 
  /// There are two types of cloning: shallow copying or deep copying.
  /// 
  /// * Shallow copying only copies reference to the fields of the original object, which means changing
  /// the field in the new object will change the field in the original object.
  /// * Deep copying makes new objects for the fields of th original object, making the original object
  /// and the new object completely independent.
  Object clone();
}