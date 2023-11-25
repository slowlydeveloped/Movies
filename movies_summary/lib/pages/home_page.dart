import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_summary/main.dart';
import 'package:movies_summary/pages/search_page.dart';

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
      print(response.body);
      movies = data.map((item) => Movie.fromJson(item)).toList();

      for (var movie in movies) {
        print('Title: ${movie.name}, Summary: ${movie.summary}');
      }

      setState(() {});
    } else {
      throw Exception("Failed to load data");
    }

    //   setState(() {
    //     movies = data.map((item) {
    //       return Movie(
    //         name: item['name'] ?? 'Unknown name',
    //         summary: item['summary'] ?? 'No summary available',
    //         // imageUrl: item['iamge'] ?? '',
    //       );
    //     }).toList();
    //   });
    // } else {
    //   if (kDebugMode) {
    //     print(' Failed to load movies');
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Movie Summary"),
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildMovieList(),
    );
  }

  Widget _buildMovieList() {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index].name),
          subtitle: Text(movies[index].summary),
          leading: Image.network(
            "https://static.tvmaze.com/uploads/images/medium_portrait/413/1034988.jpg",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
          onTap: () {
            //handle movie item click, navigate to details screen.
          },
        );
      },
    );
  }
}
