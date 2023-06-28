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
      "url": "https://pt.wikipedia.org/wiki/Wikip%C3%A9dia:P%C3%A1gina_principal"
    },
    {
      "title": "About 2",
      "abstract": "About tananam 2",
      "url": "https://pt.wikipedia.org/wiki/Kyri%C3%A1kos_Mitsot%C3%A1kis"
    }
  ]
  ''';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(json);
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 200,
                  height: 130,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Image.asset('assets/logo/cropped_logo.png'),
                ), // Espaço entre os campos
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            focusColor: Colors.orange,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            hintText: 'Uai, cadê o trem lá...'),
                        onSubmitted: (value) => Navigator.pushNamed(
                            context, SearchResult.route,
                            arguments: value.toString()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]["title"]),
                    subtitle: Text(data[index]["abstract"]),
                    hoverColor: const Color.fromARGB(255, 253, 201, 13),
                    //on click, go to data[index]["url"]
                    onTap: () => debugPrint(data[index]["url"]),
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
        ),
      ),
    ));
  }
}
