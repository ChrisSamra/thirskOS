import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/event_feed/event_display.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/dev_function_page.dart';
import 'package:thirsk_outer_space/general/version_number.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/pages/home_page.dart';
import 'package:thirsk_outer_space/pages/thrive_page.dart';
import 'package:thirsk_outer_space/pages/settings_page.dart';

// constants that hold all the resource links within thirskOS primarily on the thrive page, this is modular in the sense that it's easy to swap out links
// and add new ones when needed with little programing knowledge

// ///Don't steal my api key
//const String APP_API_KEY = "AIzaSyCE5gLyCtDW6dzAkPBowBdeXqAy5iw7ebY";

void main() {
  runApp(MyApp());
}


/// The page that contains the events posted by the teachers.
class EventPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container( child: ListView(
      children: <Widget>[


        new Image(image: new AssetImage('assets/title.png'), alignment: new Alignment(-0.87, -0.87),),

        new Container(
          height: 5.0,
        ),

        new Text("| Arts | Athletics | CTS | Wellness | ", style: new TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'LEMONMILKLIGHT',letterSpacing: 4, ), textAlign: TextAlign.center,),

        new Container(
          height: 10.0,
        ),

        //OneEventPost(postJson: '',),
        AllEventPosts(websiteUrl: "http://rths.ca/thirskOS/Posts.php", cacheLocation: "event_feed") //grabs post information (ask Roger)

      ],
    ));
  }
}  //Events Page

/// The core app.
class MyApp extends StatelessWidget {
  // This widget is the root of the application, the skeleton if you will.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //maintains vertical orientation
    getAppInfo();
    return new MaterialApp(
      title: "thirskOS",
      color: Theme.of(context).backgroundColor,

      home: Builder(
        builder: (context) => DefaultTabController(
          initialIndex: 1,
          length: 4,
          child: new Scaffold(
            body: TabBarView(
              children: [
                new Container(
                  child: new ThrivePage(
                    buttons: <ThriveButtonData>[
                      ThriveButtonData('CLUBS',(){launchURL(clubURL);}),
                      ThriveButtonData('FINE ARTS',(){launchURL(faURL);}),
                      ThriveButtonData('CTS',(){goToPage(context, CtsPage());}),
                      ThriveButtonData('SPORTS',(){goToPage(context, SportsPage());}),
                      ThriveButtonData('THE DOCK',(){launchURL(dockURL);}),
                      ThriveButtonData('EDVENTURE',(){launchURL(edURL);}),
                      ThriveButtonData('CONNECT NEWSLETTER',(){launchURL(connectURL);}),
                      ThriveButtonData('TEACHER CONTACT LIST',(){launchURL(staffURL);}),
                      ThriveButtonData('CAREER OPPOTUNITY',(){launchURL(coURL);}),
                      ThriveButtonData('SCHOLARSHIP',(){launchURL(scholarURL);}),
                      ThriveButtonData('DIPLOMA EXAMS',(){goToPage(context, DiplomaPage());}),
                      ThriveButtonData('GRADUATION',(){launchURL(gradURL);}),
                      ThriveButtonData('POSTSECONDARY',(){launchURL(psURL);}),
                      ThriveButtonData('SECRET OPTIONS',(){goToPage(context, MarkdownTest());}),

                    ],
                    initColor: Colors.lightBlue[300],
                    finalColor: Colors.purple,
                  ),
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).backgroundColor,
                ),

                new Container(
                  child: new HomePage(),
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).backgroundColor,
                ),

                new Container(
                  child: new EventPage(),
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).backgroundColor,
                ),

                new Container(
                  child: new SettingsPage(),
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).backgroundColor,
                ),
                //containers of the three pages

              ],
            ),
            bottomNavigationBar: new TabBar( //creates bottom navigation bar
              tabs: [
                Tab(
                  child: new NavigationButton(buttonImage: 'assets/thrive.png', buttonText: getString('thrive/button')),
                ),

                Tab(
                  child: new NavigationButton(buttonImage: 'assets/home.png', buttonText: getString('home/button')),
                ),

                Tab(
                  child: new NavigationButton(buttonImage: 'assets/event.png', buttonText: getString('event/button')),
                ),

                Tab(
                  child: new NavigationButton(buttonImage: 'assets/settings.png', buttonText: getString('settings/button')),
                ),
              ],
              //labelColor: Colors.blue,
              //unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.all(20),
              indicatorPadding: EdgeInsets.all(6.0),
              indicatorColor: Colors.white,
            ),
            backgroundColor: Theme.of(context).bottomAppBarColor,// Color(0xFF2D2D2D), //app background colour
          ),
        ),
      ),
      /// This part defines the general theme of the app.
      /// If possible, this should be used from the app rather than redefining a new theme for text.
      theme: ThemeData(
        textTheme: TextTheme(
          // The default text style. Used throughout the application
          body1: TextStyle(
            fontSize: 14,
            fontFamily: 'ROCK'
          ),
          headline: TextStyle(
            fontSize: 36,
            fontFamily: 'ROCK',
          ),
          title: TextStyle(
            fontSize: 30,
            fontFamily: 'ROCK',
          ),
          subhead: TextStyle(
            fontSize: 24,
            fontFamily: 'ROCK',
          ),
          // Used in the front pages, under "ThirskOS" logo.
          subtitle: TextStyle(
            fontSize: 16,
            letterSpacing: 4,
            fontFamily: 'LEMONMILKLIGHT'
          ),
          // Used in the numerous "Under Contruction" text in subpages. Also in other smaller texts.
          body2: TextStyle(
            fontSize: 12,
            fontFamily: 'ROCK',
          ),
        ).apply(
          bodyColor: Colors.white,
        ),
        backgroundColor: Colors.grey[800],
        bottomAppBarColor: Colors.grey[850],
      ),
    );
  }
} //Skeleton of the UI


//fonts, image assets, and dependencies are listed in the pubspec.yaml file