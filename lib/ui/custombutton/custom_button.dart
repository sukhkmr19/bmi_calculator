import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  var title = '';
  var radius = 2.5;
  var padding = 14.0;
  var padding_top_bottom = 20.0;
  var color = Colors.blue[200];
  var textColor = Colors.white;
  var taps = null;

  CustomButton(
      {Key key,
      this.padding_top_bottom,
      this.taps,
      this.textColor,
      this.color,
      this.title,
      this.radius,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: taps,
      child: new Container(
        margin: const EdgeInsets.all(3.0),
        padding: new EdgeInsets.fromLTRB(
            padding, padding_top_bottom, padding, padding_top_bottom),
        decoration: new BoxDecoration(
            color: color,
            borderRadius: new BorderRadiusDirectional.circular(radius)),
        child: new Text(
          title,
          style: new TextStyle(color: textColor),
        ),
      ),
    );
  }
}
