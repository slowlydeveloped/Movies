import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_summary/main.dart';
// Assuming you have a Movie class

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Movie> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text('Search Movies'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchMovies();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter search term',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    _searchMovies();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
          subtitle: Text(searchResults[index].summary),
          leading: Image.network(
            "https://static.tvmaze.com/uploads/images/medium_portrait/413/1034988.jpg",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
          onTap: () {
            // Handle tap on search result (navigate to details screen, for example)
          },
        );
      },
    );
  }

  Future<void> _searchMovies() async {
    final searchQuery = searchController.text;

    if (searchQuery.isEmpty) {
      // You may want to show a message to the user that the search term is empty
      return;
    }

    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchQuery'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(response.body);
      searchResults = data.map((item) => Movie.fromJson(item['show'])).toList();
      setState(() {});
    } else {
      // Handle error, you can show a snackbar or display an error message
      print('Failed to load search results');
    }
  }
}
