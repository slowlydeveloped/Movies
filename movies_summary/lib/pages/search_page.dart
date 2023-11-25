import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
   SearchPage({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueAccent,
      
      appBar: AppBar(
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search...",
               suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.black,),
          onPressed: () => _searchController.clear(),

        ),
        prefixIcon: IconButton(
          icon: const  Icon(Icons.search, color: Colors.black,),
          onPressed: () {
            // Perform the search here
          },
        ),
            ),
          ),
        ),
      ),
    );
  }
}