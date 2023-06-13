import 'package:flutter/material.dart';
import 'package:uai/src/screens/search/result/result.dart';

class SearchForm extends StatelessWidget {
  static const String route = '/';
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "UAI?",
      home: SearchFormQuery(),
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
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Cadê...'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange)),
                          onPressed: () {
                            Navigator.of(context).pushNamed(SearchResult.route);
                          },
                          child: const Text('Buscar'))
                    ]))));
  }
}
