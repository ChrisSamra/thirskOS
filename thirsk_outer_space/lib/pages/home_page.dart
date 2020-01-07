/// This file contains the definition of [HomePage] and other pages related to it.

import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/calendar/calendar.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/lunch_menu/menu_display.dart';

/// The home page of the application. Displays on startup.
class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) { //builds the page
    return new Container( child: ListView ( //dictates page format
      children: <Widget>[
        Image.asset('assets/title.png', ),
        // thirskOS logo at top of home page
        
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