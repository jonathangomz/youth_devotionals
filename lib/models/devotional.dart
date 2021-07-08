import 'package:flutter/material.dart';
import 'package:young_devotionals/utils/category.dart';
import 'package:young_devotionals/utils/utils_category.dart';

class Devotional {
  String title;
  DateTime date;
  String vers;
  List<String> content;
  Category category;
  String book;

  List<Widget> contentAsWidgets({TextStyle? style, TextAlign? align}) => this
      .content
      .map((e) => Text(
            e,
            style: style,
            textAlign: align,
          ))
      .toList();

  Devotional(
      {required this.title,
      required this.date,
      required this.vers,
      required this.content,
      required this.category,
      required this.book});

  Devotional.withDefaults(
      {this.title: '',
      this.vers: '',
      this.content: const [],
      this.category: Category.none,
      this.book: '',
      DateTime? customDate})
      : this.date = customDate ?? DateTime(1997, 01, 15);

  Devotional.empty()
      : this.title = '',
        this.date = DateTime.now(),
        this.vers = '',
        this.content = [],
        this.category = Category.none,
        this.book = '';

  factory Devotional.fromJson(Map<String, dynamic> json) => Devotional(
      title: json['title'] ?? '',
      date: DateTime.parse(json['date'] ?? '1997-01-15'),
      vers: json['vers'] ?? '',
      content: List<String>.from(json['content'] ?? []),
      category: fromStringToCategory(json['category'] ?? ''),
      book: json['book'] ?? '');
}
