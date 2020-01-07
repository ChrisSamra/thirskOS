import 'package:flutter/material.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/version_number.dart';

class SettingsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) { //builds the page
    return new Container(
      child: ListView ( //dictates page format
        children: <Widget>[
          Image.asset('assets/title.png', ),
          Container(height: 15.0,),
          RawMaterialButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.info),
                Text("About"),
              ],
            ),
            onPressed: ()=>{},
          ),
        ],
      ),
    );
  }
} //Home Page