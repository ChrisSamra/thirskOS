/// This file contains the definition of [ThrivePage] and other pages related to it.

import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';

const ctsURL ="";//placeholder for button link for cts page

const esURL = 'https://alberta.ca/assets/documents/ed-diploma-exam-schedule.pdf';
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
        style: Theme.of(context).textTheme.subtitle,
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
    return new Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[

          new Container(
            height: 30.0,

          ),

          new PreviousPageButton(),

          new Container(
            height: 20.0,

          ),

          new ThriveButton(
            buttonName: 'EXAM SCHEDULE',
            fillColor: Colors.indigo,
            onPressed: ()=>launchURL(esURL),
          ),

          new Container(
            height: 15.0,

          ),

          new Text(
            "Resources:",
            style: new TextStyle(
              fontFamily: 'ROCK',
              fontSize: 24,
              letterSpacing: 2,
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
            height: 2.0,
          ),
          new ThriveButton(
            buttonName: 'EXAMPLARS AND PRACTICE FROM PREVIOUS DIPLOMAS',
            fillColor: Colors.indigo,
            onPressed: (){launchURL(expcURL);},
          ),

          new Text(
            getString('misc/under_construction'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),

        ],
      ),
    );
  }
} //Exam Resources Page

/// The page which displays resources regarding CTS. I have no idea why Chris wants to add that.
class CtsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[

          new Container(
            height: 30.0,

          ),

          new PreviousPageButton(),

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
            style: Theme.of(context).textTheme.caption,
          ),

        ],
      ),
    );
  }
}  //CTS Page

/// Information regarding sports.
class SportsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[

          Container(
            height: 30.0,
          ),
          
          PreviousPageButton(),
          
          Image(image: new AssetImage('assets/cometslogo.png'), alignment: new Alignment(-0.87, -0.87), width: 325,),
          
          Container(
            height: 10.0,

          ),


          Text("ATHLETICS", style: new TextStyle( fontFamily: 'ROCK', letterSpacing: 6, fontSize: 30,),),

          Container(
            height: 20.0,

          ),

          Text("Team Games Schedule:", style: new TextStyle( fontFamily: 'ROCK', fontSize: 20, letterSpacing: 2),),

          Container(
            height: 10.0,

          ),

          ThriveButton(
            buttonName:'CALGARY SENIOR HIGH SCHOOL ATHLETIC ASSOCIATION',
            fillColor: Colors.indigo,
            onPressed: ()=>launchURL(chssURL),
          ),

          Container(
            height: 20.0,

          ),

          Text(
            getString('misc/under_construction'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
} //Athletics Page