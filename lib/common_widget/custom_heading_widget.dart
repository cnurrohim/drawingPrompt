import 'package:flutter/material.dart';

class CustomHeadingWidget extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final Color? fontColor;
  final FontStyle? fontStyle;

  // ignore: use_key_in_widget_constructors
  const CustomHeadingWidget(this.title, this.fontSize, this.fontColor, {this.fontStyle = FontStyle.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontStyle: fontStyle,
        fontSize: fontSize,
        color: fontColor
      ),
    );
  }
}