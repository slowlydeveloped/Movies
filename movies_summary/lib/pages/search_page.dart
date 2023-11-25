import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies_summary/pages/details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchQuery = '';
  var jsonList;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    try {
      var response = await Dio()
          .get('https://api.tvmaze.com/search/shows?q=${searchQuery.replaceAll(" ", "%20")}');
      if (response.statusCode == 200) {
        setState(() {
          // Limit the list to the first 10 items
          jsonList = (response.data as List).take(9).toList();
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        foregroundColor: Colors.grey,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchQuery = _searchController.text;
                getData();
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            // Set the value to searchQuery
            setState(() {
              searchQuery = value;
              getData();
            });
          },
        ),
        centerTitle: true,
      ),
      body: Container(
         padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: Colors.black87,
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
               color: Colors.amber,
              shadowColor: Colors.white,
              elevation: 5,
              child: ListTile(
                onTap: () {
                  // Navigate to DetailsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(imageUrl: jsonList[index]['show']['image']['medium'], name: jsonList[index]['show']['name'], summary: jsonList[index]['show']['summary'],),
                    ),
                  );
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.network(
                    jsonList[index]['show']['image']['medium'] ?? '',
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(jsonList[index]['show']['name'] ?? '',
                 style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )),
                subtitle: Text(jsonList[index]['show']['sumary'] ?? '',
                style: const TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.brown)),
              ),
            );
          },
        ),
      ),
    );
  }
}
