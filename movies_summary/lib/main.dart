
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movies_summary/pages/details_page.dart';
import 'package:movies_summary/pages/search_page.dart';
import 'package:movies_summary/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies List',
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var jsonList;

  @override
  void initState() {
    getData();
  }

  void getData() async {
    try {
      var response =
          await Dio().get('https://api.tvmaze.com/search/shows?q=all');
      if (response.statusCode == 200) {
        setState(() {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text(
          'Movies List ',
          style: TextStyle(color: Colors.white),
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
                contentPadding: EdgeInsets.all(12),
                leading: ClipRRect(
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
                subtitle: Text(jsonList[index]['show']['summary'] ?? '',
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
