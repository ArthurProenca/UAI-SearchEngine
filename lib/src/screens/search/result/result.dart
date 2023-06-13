import 'package:flutter/material.dart';
import 'dart:convert';

class SearchResult extends StatelessWidget {
  static const String route = '/result';

  const SearchResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Resultados",
      home: SearchResultPage(),
    );
  }
}

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchResultPage();
}

class _SearchResultPage extends State<SearchResultPage> {
  final json = '''
  [
    {
      "title": "About",
      "abstract": "About tananam",
      "url": "wikipedia.com/about"
    },
    {
      "title": "About 2",
      "abstract": "About tananam 2",
      "url": "wikipedia.com/about2"
    }
  ]
  ''';

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(json);
    return Scaffold(
      appBar: AppBar(
        title: const Text("UAI... Achamo!"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]["title"]),
            subtitle: Text(data[index]["abstract"]),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          );
        },
      ),
    );
  }
}
