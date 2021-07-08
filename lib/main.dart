import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/DailyDevotional.dart';

void main() {
  runApp(YouthDevotinals());
}

class YouthDevotinals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Youth Devotionals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      home: DailyDevotional(),
    );
  }
}
