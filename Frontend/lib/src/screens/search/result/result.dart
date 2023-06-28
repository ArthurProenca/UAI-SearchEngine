import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/Search_Result_DTO.dart';
import 'package:uai/src/domain/result/search_result_dto_list.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class SearchResult extends StatelessWidget {
  static const String route = '/result';

  const SearchResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String query = ModalRoute.of(context)!.settings.arguments.toString();

    log(query);
    return MaterialApp(
      title: "Resultados",
      home: SearchResultPage(query),
      routes: {
        SearchResult.route: (context) => const SearchResult(),
      },
    );
  }
}

class SearchResultPage extends StatefulWidget {
  final String query;
  const SearchResultPage(this.query, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SearchResultPage();
}

class _SearchResultPage extends State<SearchResultPage> {
  final controller = TextEditingController();
  String query = "";

  late Future<SearchResultDTOList> resultDTO;

  @override
  void initState() {
    super.initState();
    query = widget.query;

    resultDTO = get(query);
  }

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
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.asset('assets/logo/cropped_logo.png'),
                ), // Espaço entre os campos
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            focusColor: Colors.orange,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            hintText: 'Uai, cadê o trem lá...'),
                        onSubmitted: (value) => Navigator.of(context)
                            .pushNamed(SearchResult.route, arguments: value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<SearchResultDTOList>(
                future: resultDTO,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.searchResultDTOList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data?.searchResultDTOList[index].title ??
                                  ""),
                          subtitle: Text(
                              snapshot.data?.searchResultDTOList[index].abs ??
                                  ""),
                          hoverColor: const Color.fromARGB(255, 253, 201, 13),
                          //on click, go to data[index]["url"]
                          onTap: () async {
                            var url =
                                snapshot.data?.searchResultDTOList[index].url;
                            if (await canLaunchUrlString(url!)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
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

  Future<SearchResultDTOList> get(String query) async {
    final response = await http.get(
        Uri.parse('http://localhost:9090/api/v1/search?query=$query&page=1'));

    return SearchResultDTOList((jsonDecode(response.body) as List)
        .map((e) => SearchResultDTO.fromJson(e))
        .toList());
  }
}
