import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  String? title;
  String? id;
  Color? color;

  Category({
    required this.id,
    required this.title,
    this.color=Colors.orange

  });
}
