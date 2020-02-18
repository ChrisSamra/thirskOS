/// This file defines all functions and classes related to the event system on the event page.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
//import 'package:path_provider/path_provider.dart';
//import 'package:date_format/date_format.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:sprintf/sprintf.dart';
//import 'dart:io';

part 'event_display.g.dart';

///A post in the event feed. Can be converted to or from JSON
@JsonSerializable()
class OnePostData
{
  @JsonKey(name:"Post_id")
  String postId;
  String name;
  String uid;
  //@JsonKey(name:"Title")
  String title;
  //String email;
  @JsonKey(name:"content")
  String postContent;
  //@JsonKey(name:"date")
  String postDate;
  OnePostData({this.postId,this.name,this.uid,this.title,this.postContent,this.postDate});
  factory OnePostData.fromJson(Map<String, dynamic> json) => _$OnePostDataFromJson(json);
  factory OnePostData.directFromJson(String jsonVal){
    Map tempMap = json.decode(jsonVal);
    return OnePostData.fromJson(tempMap);
  }

  Map<String, dynamic> toJson() => _$OnePostDataToJson(this);

  DateTime get postDateTime{
    return DateFormat("d-M-y (H:m:s)").parseUTC(postDate);
  }
  String get postDateReadable{
    return DateFormat("hh:mm:ss aa, MMMM d, yyyy").format(postDateTime.toLocal());
  }
  Duration timeSincePost([DateTime current]){
    var currentTime = current??DateTime.now().toUtc();
    return currentTime.difference(postDateTime);
  }
  String get deltaTimeDisplay{
    var deltaTime = timeSincePost();
    if(deltaTime.isNegative) {
      print(deltaTime.toString());
      return getString('event/time/future');

    }
    else{
      if(deltaTime.inDays >= 730)
        return sprintf(getString('event/time/years_ago'),[deltaTime.inDays ~/ 365]);
      else if(deltaTime.inDays >= 365)
        return getString('event/time/a_year_ago');
      else if(deltaTime.inDays >= 60)
        return sprintf(getString('event/time/months_ago'),[deltaTime.inDays ~/ 30]);
      else if(deltaTime.inDays >= 30)
        return getString('event/time/a_month_ago');
      else if(deltaTime.inDays >= 14)
        return sprintf(getString('event/time/weeks_ago'),[deltaTime.inDays ~/ 7]);
      else if(deltaTime.inDays >= 7)
        return getString('event/time/a_week_ago');
      else if(deltaTime.inDays >= 2)
        return sprintf(getString('event/time/days_ago'),[deltaTime.inDays]);
      else if(deltaTime.inDays >= 1)
        return getString('event/time/a_day_ago');
      else if(deltaTime.inHours >= 2)
        return sprintf(getString('event/time/hours_ago'),[deltaTime.inHours]);
      else if(deltaTime.inHours >= 1)
        return getString('event/time/a_hour_ago');
      else if(deltaTime.inMinutes >= 2)
        return sprintf(getString('event/time/minutes_ago'),[deltaTime.inMinutes]);
      else if(deltaTime.inMinutes >= 1)
        return getString('event/time/a_minute_ago');
      else if(deltaTime.inSeconds >= 2)
        return sprintf(getString('event/time/seconds_ago'),[deltaTime.inSeconds]);
      else if(deltaTime.inSeconds >= 1)
        return getString('event/time/a_second_ago');
      else
        return getString('event/time/now');
    }
  }
}
class AllEventData{
  List<OnePostData> posts;
  AllEventData({this.posts});
  factory AllEventData.fromJson(List<dynamic> json){
    List<OnePostData> newList = new List<OnePostData>();
    newList = json.map((i)=>OnePostData.fromJson(i)).toList();
    return AllEventData(posts: newList);
  }
  factory AllEventData.directFromJson(String jsonVal){
    List<dynamic> tempMap = json.decode(jsonVal);
    //print(tempMap);
    return AllEventData.fromJson(tempMap);
  }
}
///The widget that displays a [OnePostData]'s JSON. Is the preview of [OneEventPostDetail]
class OneEventPost extends StatelessWidget{
  
  //final String postJson;
  final OnePostData postData;
  //
  final int previewStringLength;
  
  OneEventPost({Key key, postJson,OnePostData postData, this.previewStringLength = 200}) :
    this.postData = postData ?? OnePostData.directFromJson(postJson), super(key:key);
  
  @override
  Widget build(BuildContext context) {
    try {
      var truncateString = (String str) => str.length > previewStringLength ? str.substring(0,previewStringLength-3) + "..." : str;
      return Container(
        child: RawMaterialButton(
          child: Column(
            children: <Widget>[
              Text(postData.title, style: TextStyle(fontSize: 18.0, fontFamily: 'ROCK',),),

              Text(
                //takes post content searches for links and makes them clickable
                //onOpen: (link) async => launchURL(link.url),
                truncateString(postData.postContent.replaceAll('#039;', '\'')), //replaces html code for ' with ' character
                style: appTextTheme(context).bodyText1,
                //linkStyle: TextStyle(color: Colors.black),
              ),

              Text(""),
              Row(
                children: <Widget>[
                  Text(""),
                  //Text(postData.name, style: appTextTheme(context).bodyText1,), //not working properly (spits out "Array") (probably a backend issue
                  Text(
                    postData.deltaTimeDisplay,
                    style: appTextTheme(context).bodyText1,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          fillColor: Color(0xff5762db),
          padding: EdgeInsets.all(10.0),
          onPressed: ()=>goToPage(context, OneEventPostDetail(postData: postData,)),
        ),
        margin: EdgeInsets.all(10.0),
      );

    } catch (e) {
      //rethrow;
      return Text("Oopsie doopsie we screwed up");
    }
  }
}
///The detailed page of a [OneEventPost]
class OneEventPostDetail extends StatelessWidget{
  final OnePostData postData;
  OneEventPostDetail({Key key, @required this.postData}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(height: 30.0,),

            PreviousPageButton(),

            Container(height: 20.0,),

            Text(
              postData.title,
              style: TextStyle(fontSize: 28.0, fontFamily: 'ROCK',),
              textAlign: TextAlign.center,
            ),

            //Container(height: 10.0,),

            Row(
              children: <Widget>[
                Text("by " + postData.name),
                Text(postData.postDateReadable),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Divider(color: Colors.white,),
            Container(
              width:double.infinity,
              child: Linkify(
                //takes post content searches for links and makes them clickable
                onOpen: (link) async => launchURL(link.url),
                text: postData.postContent.replaceAll('#039;', '\''), //replaces html code for ' with ' character
                style: TextStyle(fontSize: 16, fontFamily: 'ROCK',),
                linkStyle: TextStyle(color: Colors.blue[800]),
                textAlign: TextAlign.left,
              ),
            ),

          ],
        ),
        margin: EdgeInsets.only(left:10.0,right:10.0),
      ),
    );
  }
}
///The Event page which contains all the events
class AllEventPosts extends WebInfoDisplayer{
  @override
  Widget buildCoreWidget(String data, WebInfoDisplayerState state) {
    AllEventData jsonData = AllEventData.directFromJson(data);
    List<Widget> convertedData = [];
    for(var oneData in jsonData.posts){
      convertedData.add(OneEventPost(postData: oneData));
    }
    return Column(
      children: convertedData,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ); 
  }
  AllEventPosts({Key key, @required String websiteUrl, @required String cacheLocation}) : super(key:key,websiteUrl:websiteUrl,cacheLocation:cacheLocation);
}