import 'package:flutter/material.dart';
import 'package:uai/src/screens/search/result/result.dart';

class SearchForm extends StatelessWidget {
  static const String route = '/';
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UAI?",
      home: const SearchFormQuery(),
      routes: {
        SearchResult.route: (context) => const SearchResult(),
      },
    );
  }
}

class SearchFormQuery extends StatefulWidget {
  const SearchFormQuery({super.key});

  @override
  State<StatefulWidget> createState() => _SearchFormQuery();
}

class _SearchFormQuery extends State<SearchFormQuery> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
                width: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        padding: const EdgeInsets.all(40),
                        child: Image.asset('assets/logo/logo.png'),
                      ),
                      TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              focusColor: Colors.orange,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              hintText: 'Uai, cadê o trem lá...'),
                          onSubmitted: (value) => Navigator.of(context)
                              .pushNamed(SearchResult.route, arguments: value)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 253, 201, 13))),
                          onPressed: () {
                            Navigator.of(context).pushNamed(SearchResult.route,
                                arguments: controller.text);
                          },
                          child: const Text('Buscar'))
                    ]))));
  }
}
