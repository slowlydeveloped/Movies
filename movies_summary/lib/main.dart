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
  // final String image; // This is the medium image URL

  Movie({
    required this.name,
    required this.summary,
    // required this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['show']['name'] ?? 'Unknown name',
      summary: json['show']['summary'] ?? 'No summary available',
      // image: json['show']['image'] ??
      //     'https://static.tvmaze.com/uploads/images/medium_portrait/413/1034988.jpg', // Access the medium image URL
    );
    
  }
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}
