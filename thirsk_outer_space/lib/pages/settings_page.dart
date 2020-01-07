import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/version_number.dart';

class SettingsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) { //builds the page
    return new Container(
      child: ListView ( //dictates page format
        children: <Widget>[
          Image.asset('assets/title.png', ),
          Container(height: 15.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.info),
                Text("Aboot"),
              ],
            ),
            onPressed: ()=>{},
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.people),
                Text("Credits"),
              ],
            ),
            onPressed: () => goToPage(context, CreditPage()),
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.access_time),
                Text("Changelog"),
              ],
            ),
            onPressed: ()=>{},
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.settings),
                Text("Preference"),
              ],
            ),
            onPressed: ()=>{},
          ),
          Container(height: 5.0,),
        ],
      ),
    );
  }
} //Home Page

/// The page that displays the people who made this app
class CreditPage extends StatelessWidget{  //Development credits page
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[800],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              height: 30.0,

            ),

            PreviousPageButton(),
            //back button to return to previous page

            new Container(
              height: 20.0,

            ),

            new Image(
              image: new AssetImage('assets/icf.png'),
              height: 160,
            ),

            new Container(
              height: 10.0,

            ),

            new Text(
              getString('credit/app_title'),
              style: new TextStyle(
                fontFamily: 'ROCK',
                letterSpacing: 4,
                fontSize: 22,
                color: Color(0xFF5d9dfa),
              ),
            ),

            new Text(
              "${getString('credit/version')}: ${appInfo.version}" +
                (appInfo.buildNumber != null && appInfo.buildNumber != "" ? "+${appInfo.version}" : ""),
              style: new TextStyle(
                fontFamily: 'ROCK',
                fontSize: 12,
                color: Color(0xFF5d9dfa),
                letterSpacing: 2,
              ),
            ),

            new Container(
              height: 20.0,
            ),

            new Text(
              getString('credit/2018/header'),
              style: new TextStyle(
                  fontFamily: 'ROCK',
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 2),
            ),

            new Container(
              height: 3.0,

            ),

            new Text(
              getString('credit/2018/credit'),
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 14),

            ),
            new Container(height:20.0),
            new Text(
              getString('credit/2019/header'),
              style: new TextStyle(
                  fontFamily: 'ROCK',
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 2),
            ),

            new Container(
              height: 3.0,

            ),

            new Text(
              getString('credit/2019/credit'),
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 14),

            ),
          ],
        ),
      ),
    );
  }
} //Dev Credits Page