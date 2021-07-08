import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:young_devotionals/api/statics.dart';
import 'package:young_devotionals/models/devotional.dart';

Future<Devotional?> fetchDailyDevotional() async {
  bool isOk = true;
  http.Response? res;
  try {
    res = await http
        .get(Uri.https(url, '/api/v1/books/60e4bc63e531a809b5bb0fbb/today'));
  } catch (e) {
    isOk = false;
  }
  Devotional? devotional;

  if (isOk && res != null && res.statusCode <= 299 && res.statusCode >= 200) {
    devotional = Devotional.fromJson(jsonDecode(res.body));
  } else if (res != null && res.statusCode == 404) {
    devotional = Devotional.withDefaults(
        title: 'Ups',
        content: ['El devocional para esta fecha no lo he escrito jeje 😅']);
  }
  return devotional;
}
