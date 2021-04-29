import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsappsunil/Models/NewsModel.dart';

class NewsService {
  static Future<News> getNews() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=4220e275ffd84420b557112d62e68d46";
    try {
      Response response = await http.get(url, headers: headers);
      debugPrint('News API :' + response.body);

      if (response.statusCode == 200) {
        return News.fromJson(json.decode(response.body));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }
}
