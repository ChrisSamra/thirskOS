import 'package:flutter/material.dart';
//import 'package:markdown/markdown.dart';//Use for supporting markdown texts
//import 'package:flutter_html/flutter_html.dart';
import 'strings/string_getter.dart';
import 'dart:io';

class MarkdownTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Color(0xff424242),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
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
          /*Html(
            data:"""
            <h1>Super Secret Development Test Page</h1>
            <p>Congratulations! You found the <i>"secret"</i> development page of thirskOS! This page is used to test out this neat feature that parses HTML to flutter widget! <b>Amazing</b>, isn't it? Providing that it works first... I don't even <i>know</i> whether this works or not.</p>
            <p>Lorem ipsum <b>dolor</b> sit amet.</p>""",
            useRichText: false,
            padding: EdgeInsets.all(8.0),
            customTextAlign: (node) => TextAlign.left,
          ),*/
        ],
      )
    );
  }
}