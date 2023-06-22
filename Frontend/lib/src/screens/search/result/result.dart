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
  final controller = TextEditingController();

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
        body: Column(
      children: [
        Row(
          children: [
            Container(
              width: 130,
              height: 130,
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Image.asset('assets/logo/logo.png'),
            ),
            const SizedBox(width: 8), // Espaço entre os campos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        focusColor: Colors.orange,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        hintText: 'Uai, cadê o trem lá...'),
                    onSubmitted: (value) => Navigator.pushNamed(context, '/'),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]["title"]),
                subtitle: Text(data[index]["abstract"]),
                hoverColor: const Color.fromARGB(255, 253, 201, 13),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Paginação',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ));
  }
}
