import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

class Recipe {
  final String uri;
  final String label;
  Recipe(this.uri, this.label);
  // factory Recipe.fromJson(Map<String, dynamic> json) {
  //   return Recipe(json['uri'] as String, json['label'] as String);
  // }
  Recipe.fromJson(Map<String, dynamic> json)
      : uri = json['uri'],
        label = json['label'];
  Map<String, dynamic> toJson() => {
        'uri': uri,
        'label': label,
      };
}
