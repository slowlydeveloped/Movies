import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_summary/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response =
        await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        movies = data.map((item) {
          return Movie(
            name: item['name'] ?? 'Unknown name',
            summary: item['summary'] ?? 'No summary available',
            // imageUrl: item['iamge'] ?? '',
          );
        }).toList();
      });
    } else {
      if (kDebugMode) {
        print(' Failed to load movies');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Movie Summary"),
      ),
      body: _buildMovieList(),
    );
  }

  Widget _buildMovieList() {
    return ListView.builder(
      itemCount: movies?.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies![index].name),
          subtitle: Text(movies![index].summary),
          // leading: Image.network(
          //   movies![index].imageUrl,
          //   width: 50.0,
          //   height: 50.0,
          //   fit: BoxFit.cover,
          // ),
          onTap: () {
            //handle movie item click, navigate to details screen.
          },
        );
      },
    );
  }
}
