import 'package:flutter/material.dart';

class ToolModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String routeName;

  ToolModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
  });
}
