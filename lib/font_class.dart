import 'dart:ui';

import 'package:flutter/material.dart';

class FontClass {
  String val;
  String font;
  double fsize;
  Color color;
  Offset position;
  TextEditingController controller;

  FontClass({
    required this.position,
    required this.controller,
    required this.val,
    required this.font,
    required this.fsize,
    required this.color,
  });
}
