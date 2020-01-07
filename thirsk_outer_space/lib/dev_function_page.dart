import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';

class MarkdownTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          PreviousPageButton(),
          MarkdownBody(
            data: """
            To be, or _not_ to be, that *is* the question.
            """,
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