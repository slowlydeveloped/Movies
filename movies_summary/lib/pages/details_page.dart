import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String summary;

  DetailsPage({required this.imageUrl, required this.name, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.black,
        shadowColor: Colors.black,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.black87,
            border: Border(bottom: BorderSide(color: Colors.white))),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              summary,
              style: const TextStyle(fontSize: 16, color: Colors.white ),
              textAlign: TextAlign.center,
              
            ),
          ],
        ),
      ),
    );
  }
}
