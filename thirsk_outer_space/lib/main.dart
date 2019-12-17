import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'calendar/calendar.dart';
import 'event_feed/event_display.dart';
import 'general_functions.dart';
import 'strings/string_getter.dart';
import 'lunch_menu/menu_display.dart';
import 'dev_function_page.dart';

const ctsURL ="";//placeholder for button link for cts page

const esURL = 'http://school.cbe.ab.ca/School/Repository/SBAttachments/87b0d243-5782-4986-8dd3-0405f8f12963_ExamScheduleJune2019.pdf';
//!REPLACE LINK ONCE NEW EXAM SCHEDULE IS POSTED FOR JAN 2020, ALSO UNCOMMENT THE EXAM SCHEDULE BUTTON ON THE EXAM RESOURCES PAGE

const dockURL = "http://school.cbe.ab.ca/school/robertthirsk/culture-environment/school-spirit/merchandise/pages/default.aspx";
const clubURL = "http://school.cbe.ab.ca/school/robertthirsk/extracurricular/clubs/pages/default.aspx";
const staffURL = "http://school.cbe.ab.ca/school/robertthirsk/about-us/contact/staff/pages/default.aspx";
const scholarURL = "http://school.cbe.ab.ca/school/robertthirsk/teaching-learning/exams-graduation/scholarships/pages/default.aspx";
const connectURL = "https://drive.google.com/drive/folders/1kWBTP-O2TFhrcSCotdCC_zcxWSNNJ3IK?usp=sharing";
const edURL = "http://edventure.rths.ca/";
const faURL = "http://school.cbe.ab.ca/school/robertthirsk/teaching-learning/classes-departments/fine-arts/pages/default.aspx";
const gradURL = 'http://school.cbe.ab.ca/school/robertthirsk/teaching-learning/exams-graduation/graduation/pages/default.aspx';
const psURL = 'http://school.cbe.ab.ca/school/robertthirsk/about-us/news-centre/_layouts/ci/post.aspx?oaid=aa6fd0ba-b1b6-4896-9912-b49bb6f2cd57&oact=20001';
const chssURL = 'http://calgaryhighschoolsports.ca/divisions.php?lang=1';
const coURL = 'http://school.cbe.ab.ca/school/robertthirsk/about-us/news-centre/_layouts/ci/post.aspx?oaid=81469bbc-eec0-4fa8-8cf1-815ac261fbe7&oact=20001';
const adpURL = 'http://www.diplomaprep.com/';
const fgcURL = 'https://rogerhub.com/final-grade-calculator/';
const expcURL = 'https://www.alberta.ca/writing-diploma-exams.aspx?utm_source=redirector#toc-2';
const qappURL = 'https://questaplus.alberta.ca/PracticeMain.html#';

// constants that hold all the resource links within thirskOS primarily on the thrive page, this is modular in the sense that it's easy to swap out links
// and add new ones when needed with little programing knowledge

///Don't steal my api key
//const String APP_API_KEY = "AIzaSyCE5gLyCtDW6dzAkPBowBdeXqAy5iw7ebY";


void main() => runApp(MyApp());

/// A button for all your navigation needs. Displays on the bottom of the app.
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
              letterSpacing: 5,
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
  /// The color to be filled in the button.
  final Color fillColor;
  /// Action to take when the button is pressed.
  final Function onPressed;

  ThriveButton({Key key, @required this.buttonName, this.fillColor, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return new RawMaterialButton(  //creates button
      child: Text(buttonName, style: TextStyle(color: Colors.white, fontFamily: 'LEMONMILKLIGHT', fontSize: 18, letterSpacing: 4),),
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

/// The home page of the application. Displays on startup.
class HomePage extends StatelessWidget{

  //if/else statement which essentially says when the focus/connect rooms link is to be opened, how will it be opened on both IOS and ANDROID
  //else just gives a print statement


  @override
  Widget build(BuildContext context) { //builds the page
    //variables of images and text to be on the page

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

/// The page that displays the people who made this app
class CreditPage extends StatelessWidget{  //Development credits page

  @override
  Widget build(BuildContext context) {
    return new Material( color: Colors.grey[800], child: Column(
      children: <Widget>[

        new Container(
          height: 30.0,

        ),

        new RawMaterialButton(
          child: Text(
            getString('misc/back'),
            style: TextStyle(color: Colors.white, fontSize: 18,),
          ),
          shape: StadiumBorder(),
          highlightColor: Color(0x0083ff),
          padding: EdgeInsets.all(5),
          fillColor: Colors.black12,
          splashColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          getString('credit/version'),
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
    );
  }
} //Dev Credits Page

///The "Thrive" page which displays links to useful resources on many CBE websites. Why it is not in-app? Who knows.
class ThrivePage extends StatelessWidget{  //Thrive Page

  /// A list of buttons to be displayed on [ThrivePage]
  final List<ThriveButtonData> buttons;
  /// The fill color of the first button on [ThrivePage]
  final Color initColor;
  /// The fill color of the last button on [ThrivePage], if there is more than 1 buttons.
  final Color finalColor;
  ThrivePage({Key key, this.buttons, this.initColor, this.finalColor}) : super(key:key);

  //if statements which essentially say when the links are to be opened, how they are going to be opened on both IOS and ANDROID
  //else just gives a print statement


  @override
  Widget build(BuildContext context) {
    var returnVal = <Widget>[
      new Image(
        image: new AssetImage('assets/title.png'),
        alignment: new Alignment(-0.87, -0.87),
      ),

      new Container(
        height: 5.0,
      ),

      new Text(
        getString('thrive/thrive_prompt'),
        style: new TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontFamily: 'LEMONMILKLIGHT',
          letterSpacing: 4,
        ),
        textAlign: TextAlign.center,
      ),

      new Container(
        height: 10.0,
      ),
    ];
    var i = 0;
    // The colors of the buttons are calculated linearly in [ThrivePage]. Each button are added to the list one by one.
    for(var oneButtonData in buttons){
      returnVal.add(new ThriveButton(
          buttonName: oneButtonData.name,
          fillColor: (HSVColor.lerp(HSVColor.fromColor(initColor), HSVColor.fromColor(finalColor), buttons.length <= 1 ? 0 : i.toDouble() / buttons.length).toColor()),
          onPressed: oneButtonData.clickAction
      ));
      returnVal.add(new Container(height: 5.0,));
      i++;
    }
    return new Container( child: ListView(
      children: returnVal,
    ));

  }
}  //Thrive Page

/// The page which displays information regarding Diploma Exams.
class DiplomaPage extends StatelessWidget{   //Built in page for Exam Resources

  @override
  Widget build(BuildContext context) {
    return new Material( color: Colors.grey[800], child: Column(
      children: <Widget>[

        new Container(
          height: 30.0,

        ),

        new RawMaterialButton(
          child: Text(getString('misc/back'), style: TextStyle(color: Colors.white, fontSize: 18,),),
          shape: StadiumBorder(),
          highlightColor: Color(0x0083ff),
          padding: EdgeInsets.all(5),
          fillColor: Colors.black12,
          splashColor: Colors.white,

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        new Container(
          height: 20.0,

        ),

        new Text(
          "Exams",
          style: new TextStyle(
              fontFamily: 'ROCK',
              fontSize: 36,
              color: Colors.white,
              letterSpacing: 2
          ),
        ),

        new Container(
          height: 15.0,

        ),

        new Text(
          "Resources:",
          style: new TextStyle(
              fontFamily: 'ROCK',
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 2
          ),
        ),

        new Container(
          height: 10.0,

        ),

        new ThriveButton(
          buttonName: 'FINAL GRADE CALCULATOR',
          fillColor: Colors.indigo,
          onPressed: (){launchURL(fgcURL);},
        ),

        new Container(
          height: 2.0,
        ),

        new ThriveButton(
          buttonName: 'ALBERTA DIPLOMA PREP COURSES',
          fillColor: Colors.indigo,
          onPressed: (){launchURL(adpURL);},
        ),
        new Container(
          height: 5.0,
        ),
        new ThriveButton(
          buttonName: 'EXAMPLARS AND PRACTICE FROM PREVIOUS DIPLOMAS',
          fillColor: Colors.indigo,
          onPressed: (){launchURL(expcURL);},
        ),

        new Text(
          getString('misc/under_construction'),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),

      ],
    ),);
  }
} //Exam Resources Page

/// The page which displays resources regarding CTS. I have no idea why Chris wants to add that.
class CtsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Material( color: Colors.grey[800], child: Column(
      children: <Widget>[

        new Container(
          height: 30.0,

        ),

        new RawMaterialButton(
          child: Text(getString('misc/back'), style: TextStyle(color: Colors.white, fontSize: 18,),),
          shape: StadiumBorder(),
          highlightColor: Color(0x0083ff),
          padding: EdgeInsets.all(5),
          fillColor: Colors.black12,
          splashColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        new Image(
          image: new AssetImage('assets/cometslogo.png'),
          alignment: new Alignment(-0.87, -0.87),
          width: 270,
        ),

        new Text(
          "CAREER TECHNOLOGY STUDIES",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontFamily: 'ROCK',
            letterSpacing: 6,
            fontSize: 20,
            color: Colors.white,
          ),
        ),

        new Container(
          height: 10.0,

        ),

        new Image(
          image: new AssetImage('assets/m1.png'),
          alignment: new Alignment(-0.87, -0.87),
          width: 350,
        ),

        new Image(
          image: new AssetImage('assets/m2.png'),
          alignment: new Alignment(-0.87, -0.87),
          width: 350,
        ),

        new Image(
          image: new AssetImage('assets/m3.png'),
          alignment: new Alignment(-0.87, -0.87),
          width: 350,
        ),
        //placeholder images promoting CTS, they can be removed and replaced with more detailed/accurate info next year

        new Container(
          height: 20.0,

        ),

        new Text(
          getString('misc/under_construction'),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),



      ],
    ),);
  }
}  //CTS Page

/// Information regarding sports.
class SportsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Material( color: Colors.grey[800], child: Column(
      children: <Widget>[

        new Container(
          height: 30.0,

        ),

        new RawMaterialButton(
          child: Text(getString('misc/back'), style: TextStyle(color: Colors.white, fontSize: 18,),),
          shape: StadiumBorder(),
          highlightColor: Color(0x0083ff),
          padding: EdgeInsets.all(5),
          fillColor: Colors.black12,
          splashColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),


        new Image(image: new AssetImage('assets/cometslogo.png'), alignment: new Alignment(-0.87, -0.87), width: 325,),

        new Container(
          height: 10.0,

        ),


        new Text("ATHLETICS", style: new TextStyle( fontFamily: 'ROCK', letterSpacing: 6, fontSize: 30, color: Colors.white,),),

        new Container(
          height: 20.0,

        ),

        new Text("Team Games Schedule:", style: new TextStyle( fontFamily: 'ROCK', fontSize: 20, color: Colors.white, letterSpacing: 2),),

        new Container(
          height: 10.0,

        ),

        new RawMaterialButton(
          child: const Text('CALGARY SENIOR HIGH SCHOOL ATHLETIC ASSOCIATION',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,letterSpacing: 4, fontFamily: 'LEMONMILKLIGHT', fontSize: 14,),),
          shape: StadiumBorder(),
          highlightColor: Color(0x0083ff),
          padding: EdgeInsets.all(5),
          fillColor: Colors.red.shade900,
          splashColor: Colors.white,

          onPressed: () {
            launchURL(chssURL);
          },
        ),

        new Container(
          height: 20.0,

        ),

        new Text(getString('misc/under_construction'), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10),),

      ],
    ),);
  }
} //Athletics Page

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
        AllEventPosts() //grabs post information (ask Roger)

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
    return new MaterialApp(
      title: "thirskOS",
      color: Colors.grey,

      home: Builder(
        builder: (context) => DefaultTabController(
          initialIndex: 1,
          length: 3,

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
                    color: Colors.grey[800],
                  ),

                  new Container(
                    child: new HomePage(),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[800],
                  ),

                  new Container(
                    child: new EventPage(),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[800],

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

                ],
                //labelColor: Colors.blue,
                //unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.all(20),
                indicatorPadding: EdgeInsets.all(6.0),
                indicatorColor: Colors.white,
              ),
              backgroundColor: Colors.grey[850]// Color(0xFF2D2D2D), //app background colour
          ),
        ),
      ),

      //theme: ThemeData(fontFamily: 'LEMONMILKLIGHT'),
      theme: ThemeData(textTheme: TextTheme(
          body1: TextStyle(fontSize: 14,color: Colors.white)
      )),
    );
  }
} //Skeleton of the UI


//fonts, image assets, and dependencies are listed in the pubspec.yaml file