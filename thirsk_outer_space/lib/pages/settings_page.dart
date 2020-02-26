import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/version_number.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// URL linking to the feedback page where the user can give feedback.
const feedbackUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfOEk0NghFI3tz1RQCE41hZJkZDCeZ5dWhSDshjYgS6ZAOIEg/viewform?usp=sf_link';

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
            onPressed: () => goToPage(context, MarkdownPage(fileLocation: 'README.md', beforeMarkdown: AppInfo(),)),
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.people),
                Text(getString('settings/credit')),
              ],
            ),
            onPressed: () => goToPage(context, MarkdownPage(fileLocation: 'CREDIT.md',)),
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.access_time),
                Text(getString('settings/changelog')),
              ],
            ),
            onPressed: () => goToPage(context, MarkdownPage(fileLocation: 'CHANGELOG.md',)),
          ),
          Container(height: 5.0,),
          ThriveButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.feedback),
                Text(getString('settings/feedback')),
              ],
            ),
            onPressed: () => launchURL(feedbackUrl),
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

/// The information of the application, include logo, version number, build number, etc.
class AppInfo extends StatelessWidget{  //Development credits page
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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

        //MarkdownBody(data: ,)

        // new Text(
        //   getString('credit/2018/header'),
        //   style: new TextStyle(
        //     fontFamily: 'ROCK',
        //     fontSize: 22,
        //     letterSpacing: 2,
        //   ),
        // ),

        // new Container(
        //   height: 3.0,

        // ),

        // new Text(
        //   getString('credit/2018/credit'),
        //   textAlign: TextAlign.left,
        // ),
        // new Container(height:20.0),
        // new Text(
        //   getString('credit/2019/header'),
        //   style: new TextStyle(
        //     fontFamily: 'ROCK',
        //     fontSize: 22,
        //     letterSpacing: 2,
        //   ),
        // ),

        // new Container(
        //   height: 3.0,

        // ),

        // new Text(
        //   getString('credit/2019/credit'),
        //   textAlign: TextAlign.left,
        // ),
      ],
    );
  }
} //Dev Credits Page

/// The page that displays literally a markdown file.
class MarkdownPage extends StatelessWidget{

  /// The location of the markdown file, in assets.
  final String fileLocation;
  /// Any widget before the markdown file.
  final Widget beforeMarkdown;
  /// Any widget after the markdown file.
  final Widget afterMarkdown;
  MarkdownPage({Key key, @required this.fileLocation, this.beforeMarkdown, this.afterMarkdown}) : super(key:key);
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

            // Image(
            //   image: new AssetImage('assets/icf.png'),
            //   height: 160,
            // ),
            
            Container(
              child: FutureBuilder<String>(
                future: loadAsset(fileLocation),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: <Widget>[
                        beforeMarkdown,
                        MarkdownBody(
                          data: snapshot.data.replaceAll("(assets/", "(resource:assets/"),
                        ),
                        afterMarkdown,
                      ]..removeWhere((widget) => widget == null),
                    );
                  } else if(snapshot.hasError){
                    return ErrorText(
                      "Error: Fail to load about page.",
                    );
                  }
                  return LoadingIndicator();
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