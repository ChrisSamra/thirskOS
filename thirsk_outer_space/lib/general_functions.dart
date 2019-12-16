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