import 'package:flutter/material.dart';
import 'package:uai/src/screens/search/result/result.dart';

class SearchForm extends StatelessWidget {
  static const String route = '/home';
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UAI",
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
      backgroundColor: const Color(0xff282c34),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 240),
        child: Center(
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
                  style: const TextStyle(
                      color:
                          Colors.grey), // Definindo a cor do texto para branco
                  decoration: const InputDecoration(
                    focusColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    suffixIcon: Icon(
                        color: Color.fromARGB(188, 252, 201, 16), Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                    ),
                    hintText: 'Uai, cadê o trem lá...',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(188, 252, 201, 16)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(188, 252, 201, 16)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                    ),
                  ),
                  onSubmitted: (value) => Navigator.of(context)
                      .pushNamed(SearchResult.route, arguments: value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
