/// This file contains the definition of [HomePage] and other pages related to it.

import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/calendar/calendar.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/lunch_menu/menu_display.dart';
import 'package:thirsk_outer_space/general/version_number.dart';

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
              "${getString('credit/version')}: ${appInfo.version}",
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
/// The home page of the application. Displays on startup.
class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) { //builds the page
    return new Container( child: ListView ( //dictates page format
      children: <Widget>[

        new RawMaterialButton(
          child: Image.asset('assets/title.png', ),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreditPage()),
            );
          },
        ),
        // thirskOS logo at top of home page
        // the image also serves as a secret button, once tapped it takes the user to the development credits page

        new Container(
          height: 5.0,
        ), //these containers act as spacers between pieces of content on the page

        new DateDisplay(),/*
        new Text(
          new DateFormat("| EEEE | MMM d | yyyy |").format(new DateTime.now(),),
          style: new TextStyle(
              fontSize: 16,
              color: Colors.white,
              letterSpacing: 4,
              fontFamily: 'LEMONMILKLIGHT'
          ),
          textAlign: TextAlign.center,
        ),*/


        //when video announcements are created at thirsk, instead of using a video player there should be a list of links inside a scrollable text box that expands
        //that list will update with every new link
        //this way it links to youtube or the web so we dont have to worry about or manage the video playback

        new Container(
          height: 10.0,
        ),

        new Text(
          getString('lunch/menu_prompt'),
          style: new TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'LEMONMILKLIGHT',
              letterSpacing: 4
          ),
          textAlign: TextAlign.center,
        ),

        MenuDisplay(menuCache: MenuCache()), //grabs cached lunch menu (ask Roger)

      ],
    ));
  }
} //Home Page