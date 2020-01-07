/// This file defines functions and classes related to the lunch menu.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
//import 'package:date_format/date_format.dart';
import 'dart:async';
import 'dart:io';
//import 'package:flutter_linkify/flutter_linkify.dart';// for later use with video links
import 'package:thirsk_outer_space/strings/string_getter.dart';
//import 'package:sprintf/sprintf.dart';
import 'package:intl/intl.dart';
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

}
///Returns the json string from the site if retrieved successfully.
///
Future<String> fetchMenu() async {
  final response = await http.get('http://rths.ca/rthsJSONmenu.php');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return response.body;
    //return '[{"menuID":"262","soup":"Cream of Broccoli","soupCost":"2.00","entree":"Steamed Hams\' Sandwich","entreeCost":"5.00","starch1":"","starch1Cost":"0.00","starch2":"","starch2Cost":"0.00","dessert":"Creme Brulee Cake","dessertCost":"2.00","menuDate":"2018-03-12"},{"menuID":"263","soup":"Vegetable Soup","soupCost":"2.00","entree":"Stuffed Peppers (Meat or Quinoa Stuffing) with Garden Salad","entreeCost":"5.00","starch1":"","starch1Cost":"0.00","starch2":"","starch2Cost":"0.00","dessert":"Squares","dessertCost":"0.00","menuDate":"2018-03-13"},{"menuID":"264","soup":"yes :)","soupCost":"2.00","entree":"Beef Burger and\/or Quinoa Burger with Baked Fries or Salad","entreeCost":"5.00","starch1":"","starch1Cost":"0.00","starch2":"","starch2Cost":"0.00","dessert":"Pie Daaayyyyyy!","dessertCost":"2.50","menuDate":"2018-03-14"},{"menuID":"265","soup":"For Sure...","soupCost":"2.00","entree":"Butter Chicken ","entreeCost":"2.00","starch1":"Basmati Rice","starch1Cost":"1.00","starch2":"fresh steamed vegetables","starch2Cost":"1.00","dessert":"Black Forest Cake","dessertCost":"2.50","menuDate":"2018-03-15"}]';
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

///Builds the layout for the input [displayMenu]
///
List<Widget> displayData(WeekMenu displayMenu){
  List<Widget> entryList = new List<Widget>();
  //displayMenu = WeekMenu.directFromJson(jsonRetrieved);
  for(OneDayMenu dayEntry in displayMenu.thisWeeksMenu){

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
            '$entryLabel: ${entryName.replaceAll('#039;', '\'')}(CAD\$$cost)',//sprintf('%s: %s(CAD\$%s)',[entryLabel,entryName.replaceAll('#039;', '\''),cost]),
            //style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          );
        } else {
          oneEntryDisplay.add(Text(
            // i used replace all to replace the html code for an apostrophe with one so it doesn't look weird
            '$entryLabel: ${entryName.replaceAll('#039;', '\'')}',
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
  return entryList;
}

///Used to cache data from the site
class MenuCache {
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/menujson.txt');
  }

  Future<String> readJson() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return '';
    }
  }
  Future<File> writeJson(String strToWrite) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(strToWrite);
  }
}

class MenuDisplay extends StatefulWidget {
  MenuDisplay({Key key, @required this.menuCache}) : super(key: key);
  //final String title;
  final MenuCache menuCache;

  @override
  _MenuDisplayState createState() => _MenuDisplayState();
}

class _MenuDisplayState extends State<MenuDisplay> {
  //int _counter = 0;
  String jsonRetrieved = '[{"menuID":"262","soup":"Cream of Broccoli","soupCost":"2.00","entree":"Ravioli with 4 Cheese Sauce","entreeCost":"5.00","starch1":"","starch1Cost":"0.00","starch2":"","starch2Cost":"0.00","dessert":"Creme Brulee Cake","dessertCost":"2.00","menuDate":"2018-03-12"},{"menuID":"263","soup":"Vegetable Soup","soupCost":"2.00","entree":"Stuffed Peppers (Meat or Quinoa Stuffing) with Garden Salad","entreeCost":"5.00","starch1":"","starch1Cost":"0.00","starch2":"","starch2Cost":"0.00","dessert":"Squares","dessertCost":"0.00","menuDate":"2018-03-13"},{"menuID":"264","soup":"yes :)","soupCost":"2.00","entree":"Beef Burger and\/or Quinoa Burger with Baked Fries or Salad","entreeCost":"5.00","starch1":"","starch1Cost":"0.00","starch2":"","starch2Cost":"0.00","dessert":"Pie Daaayyyyyy!","dessertCost":"2.50","menuDate":"2018-03-14"},{"menuID":"265","soup":"For Sure...","soupCost":"2.00","entree":"Butter Chicken ","entreeCost":"2.00","starch1":"Basmati Rice","starch1Cost":"1.00","starch2":"fresh steamed vegetables","starch2Cost":"1.00","dessert":"Black Forest Cake","dessertCost":"2.50","menuDate":"2018-03-15"}]';
  String jsonCached = '';
  WeekMenu displayMenu;
  @override
  ///Stores the cached json into a variable on when initialized
  void initState() {
    super.initState();
    widget.menuCache.readJson().then((String value) {
      setState(() {
        jsonCached = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Container(
        child: FutureBuilder<String>(
          future: fetchMenu(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              jsonRetrieved = snapshot.data;
              jsonCached = snapshot.data;
              widget.menuCache.writeJson(snapshot.data);
              displayMenu = WeekMenu.directFromJson(snapshot.data);
              var _displayData = displayData(displayMenu);
              return Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children:
                  _displayData.length != 0 ?
                  displayData(displayMenu) :
                  <Widget>[
                    Text(
                      getString('lunch/no_entry'),
                      textAlign: TextAlign.center,
                    ),
                  ]
              );
            } else if(snapshot.hasError){
              if(jsonCached == '' || jsonCached == '[]') {
                return Text('Looks like you has an error:\n${snapshot
                    .error}\nYou should probably send help.',style: TextStyle(color: Colors.red),);
              } else {
                displayMenu = WeekMenu.directFromJson(jsonCached);
                return ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Looks like you has an error:\n${snapshot
                        .error}\nWe found your latest cache.',style: TextStyle(color: Colors.red),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: displayData(displayMenu),
                    ),
                  ],
                );
              }
            }
            return Column(
              children: <Widget>[
                CircularProgressIndicator(),
                Text(getString('misc/loading')),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            );
          },
          /*Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entryList,
      ),*/
        )
    );
  }
}