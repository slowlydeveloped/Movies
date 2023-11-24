import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_summary/pages/home_page.dart';

import 'package:movies_summary/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class Movie {
  final String name;
  final String summary;
  // final String imageUrl;

  Movie({required this.name, required this.summary});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}
