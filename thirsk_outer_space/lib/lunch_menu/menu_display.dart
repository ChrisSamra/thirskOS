/// This file defines functions and classes related to the lunch menu.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
//import 'package:flutter_linkify/flutter_linkify.dart';// for later use with video links
import 'package:thirsk_outer_space/strings/string_getter.dart';
//import 'package:sprintf/sprintf.dart';
import 'package:intl/intl.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
//imported packages etc.

part 'menu_display.g.dart';

////////////////////////////////////////////////////////////////////////////
//This annotation is important for the code generation to generate code for the class
@JsonSerializable()
///A class that stores a day's menu
class OneDayMenu {
  String menuID;
  String soup;
  String soupCost;
  String entree;
  String entreeCost;
  //This annotation can be used if the json key is different from the variable name
  @JsonKey(name:'starch1')
  String starch;
  @JsonKey(name:'starch1Cost')
  String starchCost;
  @JsonKey(name:'starch1Title')
  String starchLabel;
  @JsonKey(name:'starch2')
  String veggie;
  @JsonKey(name:'starch2Cost')
  String veggieCost;
  @JsonKey(name:'starch2Title')
  String veggieLabel;
  String dessert;
  String dessertCost;
  String menuDate;
  OneDayMenu({
    this.menuID,
    this.soup,
    this.soupCost,
    this.entree,
    this.entreeCost,
    this.starch,
    this.starchCost,
    this.starchLabel,
    this.veggie,
    this.veggieCost,
    this.veggieLabel,
    this.dessert,
    this.dessertCost,
    this.menuDate
  });


  /// A necessary factory constructor for creating a new [OneDayMenu] instance
  /// from a map. Pass the map to the generated [_$OneDayMenuFromJson] constructor.
  /// The constructor is named after the source class, in this case User.
  factory OneDayMenu.fromJson(Map<String, dynamic> json) => _$OneDayMenuFromJson(json);
  ///Construct a [OneDayMenu] object directly from json string
  factory OneDayMenu.directFromJson(String jsonVal){
    Map tempMap = json.decode(jsonVal);
    return OneDayMenu.fromJson(tempMap);
  }

  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$OneDayMenuToJson].
  Map<String, dynamic> toJson() => _$OneDayMenuToJson(this);
}
///A class that stores a list of menus, usually a week
class WeekMenu{
  List<OneDayMenu> thisWeeksMenu;
  WeekMenu({this.thisWeeksMenu});
  //Since the json string is a list, we have to build a new constructor
  factory WeekMenu.fromJson(List<dynamic> json){
    List<OneDayMenu> newList = new List<OneDayMenu>();
    newList = json.map((i)=>OneDayMenu.fromJson(i)).toList();
    return WeekMenu(thisWeeksMenu: newList);
  }
  factory WeekMenu.directFromJson(String jsonVal){
    List<dynamic> tempMap = json.decode(jsonVal);
    //print(tempMap);
    return WeekMenu.fromJson(tempMap);
  }
  ///Builds the layout for the this object.
  List<Widget> displayData(){
    List<Widget> entryList = new List<Widget>();
    //displayMenu = WeekMenu.directFromJson(jsonRetrieved);
    for(OneDayMenu dayEntry in thisWeeksMenu){

      List<Widget> oneEntryDisplay = new List<Widget>();
      oneEntryDisplay.add(Text(''));
      var today=DateTime.parse(dayEntry.menuDate);
      oneEntryDisplay.add(Text(
        '${DateFormat("EEEE, LLL d").format(today)}',
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, letterSpacing: 4, fontFamily: 'LEMONMILKLIGHT' ),
        textAlign: TextAlign.center,
      ),
      );
      void addOneEntry(String entryLabel, String entryName, String cost) {
        if(entryName != ''){
          if(cost != '0.00' && cost != ''){
            oneEntryDisplay.add(Text(
              // i used replace all to replace the html code for an apostrophe with one so it doesn't look weird
              '$entryLabel: ${entryName.replaceAll('&#039;', '\'')}(CAD\$$cost)',//sprintf('%s: %s(CAD\$%s)',[entryLabel,entryName.replaceAll('#039;', '\''),cost]),
              //style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            );
          } else {
            oneEntryDisplay.add(Text(
              // i used replace all to replace the html code for an apostrophe with one so it doesn't look weird
              '$entryLabel: ${entryName.replaceAll('&#039;', '\'')}',
              //style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            );
          }
        }
      }
      addOneEntry(getString('lunch/entry/entree'),dayEntry.entree,dayEntry.entreeCost);
      addOneEntry(dayEntry.starchLabel,dayEntry.starch,dayEntry.starchCost);
      addOneEntry(dayEntry.veggieLabel,dayEntry.veggie,dayEntry.veggieCost);
      addOneEntry(getString('lunch/entry/soup'),dayEntry.soup,dayEntry.soupCost);
      addOneEntry(getString('lunch/entry/dessert'),dayEntry.dessert,dayEntry.dessertCost);
      if(oneEntryDisplay.length == 2){
        oneEntryDisplay.add(Text(
          getString('lunch/entry/no_item'),
          //'Entree: ${dayEntry.entree.replaceAll('#039;', '\'')}(CAD\$${dayEntry.entreeCost})',
          //style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
          textAlign: TextAlign.center,
        )
        );
      }
      oneEntryDisplay.add(Text(""));
      oneEntryDisplay.add(Text(""));

      entryList.add(Container(
        child: Column(
          children: oneEntryDisplay,
          //crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ));
    }
    if(entryList.length == 0){
      entryList.add(Text(getString('lunch/no_entry')));
    }
    return entryList;
  }

}

class MenuDisplay extends WebInfoDisplayer {
  MenuDisplay({Key key, @required String websiteUrl, @required String cacheLocation}) : super(key: key, websiteUrl: websiteUrl, cacheLocation: cacheLocation);

  @override
  Widget buildCoreWidget(String data, WebInfoDisplayerState state) {
    WeekMenu menu = WeekMenu.directFromJson(data);
    return Column(
      children: menu.displayData()..insert(0, Stack(
        children: <Widget>[
          Center(
            child: new Text(
              getString('lunch/menu_prompt'),
              style: new TextStyle(
                  fontSize: 22,
                  fontFamily: 'LEMONMILKLIGHT',
                  letterSpacing: 4
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            child: MaterialButton(
              child:Container(
                child: Row(children: <Widget>[Icon(Icons.refresh),Text(getString('misc/refresh'))],),
                decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.yellow[600]),
                padding: EdgeInsets.all(2.0),
                //width: 100,
              ),
              onPressed: () => state.refresh(),
            ),
            alignment: Alignment(1,1),
          ),
        ],
      )),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

}