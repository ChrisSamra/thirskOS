import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/version_number.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
                Text(getString('settings/about')),
              ],
            ),
            onPressed: () => goToPage(context, AboutPage()),
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.people),
                Text(getString('settings/credit')),
              ],
            ),
            onPressed: () => goToPage(context, CreditPage()),
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.access_time),
                Text(getString('settings/changelog')),
              ],
            ),
            onPressed: ()=>{},
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.feedback),
                Text(getString('settings/feedback')),
              ],
            ),
            onPressed: ()=>{},
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.settings),
                Text(getString('settings/preference')),
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
      color: Theme.of(context).backgroundColor,
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
                (appInfo.buildNumber != null && appInfo.buildNumber != "" ? "+${appInfo.buildNumber}" : ""),
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
                letterSpacing: 2,
              ),
            ),

            new Container(
              height: 3.0,

            ),

            new Text(
              getString('credit/2018/credit'),
              textAlign: TextAlign.left,
            ),
            new Container(height:20.0),
            new Text(
              getString('credit/2019/header'),
              style: new TextStyle(
                fontFamily: 'ROCK',
                fontSize: 22,
                letterSpacing: 2,
              ),
            ),

            new Container(
              height: 3.0,

            ),

            new Text(
              getString('credit/2019/credit'),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
} //Dev Credits Page

/// The page that displays the people who made this app
class AboutPage extends StatelessWidget{  //Development credits page
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 30.0,

            ),

            PreviousPageButton(),
            //back button to return to previous page

            Container(height: 20.0,),

            Image(
              image: new AssetImage('assets/icf.png'),
              height: 160,
            ),
            
            Container(
              child: FutureBuilder(
                future: loadAsset('README.md'),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return MarkdownBody(
                      data: snapshot.data,
                    );
                  } else if(snapshot.hasError){
                    return Text(
                      "Error: Fail to load about page.",
                      style: appTextTheme(context).body1.apply(color: ColorCoding.errorColor),
                    );
                  }
                } 
              ), 
              margin: EdgeInsets.all(20.0),
            ),
          ],
        ),
      ),
    );
  }
} //Dev Credits Page