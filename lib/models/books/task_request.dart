import 'package:flutter/material.dart';

class TaskRequest {
  final String data;
  final double fontSize;
  final double fontHeight;
  final double maxWidth;
  final double maxTextHeight;
  final EdgeInsetsGeometry padding;

  TaskRequest(this.data, this.fontSize, this.fontHeight, this.maxWidth, this.padding, this.maxTextHeight);
}