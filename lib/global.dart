library my_prj.globals;

import 'package:flutter/material.dart';

String text = "lightText";
final appColor = const Color(0xff015496); //blue
final appColorPink = const Color(0xffC72A61); //pink

class lightText extends StatelessWidget {
  final String text;
  var textColor;
  var textFontWeight;
  var textAlignment;
  lightText({@required this.text, this.textColor, this.textFontWeight,this.textAlignment});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment,
      style:
      TextStyle(fontSize: 15, color: textColor, fontWeight: textFontWeight),
    );
  }
}

class mediumText extends StatelessWidget {
  final String text;
  var textColor;
  var textFontWeight;
  mediumText({@required this.text, this.textColor, this.textFontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyle(fontSize: 20, color: textColor, fontWeight: textFontWeight),
    );
  }
}

class Largetxt extends StatelessWidget {
  String textname;
  var textcolors;
  var textfontWeight;
  var customfontSize;
  Largetxt({@required this.textname,this.textcolors,this.textfontWeight,this.customfontSize});

  @override
  Widget build(BuildContext context) {
    return Text(textname,style: TextStyle(color: textcolors,fontWeight: textfontWeight,fontSize:customfontSize),);
  }
}

class largeText extends StatelessWidget {
  final String text;
  var textColor;
  var textFontWeight;

  largeText({@required this.text, this.textColor, this.textFontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyle(fontSize: 30, color: textColor, fontWeight: textFontWeight),
    );
  }
}