import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/search_result_dto.dart';
import 'package:uai/src/domain/result/search_result_dto_list.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:uai/src/service/http_service.dart';
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
            Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: 100,
                    height: 50,
                    child: Image.asset("assets/logo/cropped_logo.png"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(30, 10, 5, 10),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildHotTopics("Geral", Icons.search_outlined),
                          buildHotTopics("Wikipedia", Icons.school),
                          buildHotTopics(
                              "Outros recursos", Icons.pageview_outlined),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<SearchResultDTOList>(
                future: resultDTO,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.searchResultDTOList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: BorderSide.strokeAlignCenter,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data?.searchResultDTOList[index]
                                          .title ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data?.searchResultDTOList[index]
                                          .abs ??
                                      "",
                                  style: const TextStyle(
                                      decoration: TextDecoration.none),
                                  textAlign: TextAlign.left,
                                ),
                                hoverColor:
                                    const Color.fromARGB(300, 253, 201, 13),
                                onTap: () async {
                                  var url = snapshot
                                      .data?.searchResultDTOList[index].url;
                                  if (await canLaunchUrlString(url!)) {
                                    await launchUrlString(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ],
                          ),
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
              color: Colors.grey[170],
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 370,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.all(
                            Radius.circular(90),
                          ),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.orange,
                        ),
                        hintText: "Uai sô, cadê!?",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(90),
                          ),
                        ),
                      ),
                      onSubmitted: (value) => {
                        Navigator.pushNamed(context, SearchResult.route,
                            arguments: value)
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildHotTopics(String text, IconData icon) {
    return SizedBox(
      child: Row(
        children: [
          Icon(icon),
          Text(text),
          const Padding(padding: EdgeInsets.fromLTRB(25, 0, 20, 0)),
        ],
      ),
    );
  }

  Future<SearchResultDTOList> get(String query) async {
    HttpService.get(Uri.parse("https://en.wikipedia.org/w/api.php"));
    const json = ''' 
    [
   {
      "title":"Functional square root",
      "url":"https://en.wikipedia.org/wiki/Functional_square_root",
      "abs":"Functional <em>square</em> <em>root</em> In mathematics a functional <em>square</em> <em>root</em> sometimes called a half iterate is a <em>square</em> <em>root</em> of a function with respect to the operation of function composition In other words a functional <em>square</em> <em>root</em> of a function is a function satisfying for all "
   },
   {
      "title":"Square root of a matrix",
      "url":"https://en.wikipedia.org/wiki/Square_root_of_a_matrix",
      "abs":"<em>Square</em> <em>root</em> of a matrix In mathematics the <em>square</em> <em>root</em> of a matrix extends the notion of <em>square</em> <em>root</em> from numbers to matrices "
   },
   {
      "title":"Square root",
      "url":"https://en.wikipedia.org/wiki/Square_root",
      "abs":"Notation for the principal <em>square</em> <em>root</em> of For example since or <em>squared</em> "
   },
   {
      "title":"Square root of 6",
      "url":"https://en.wikipedia.org/wiki/Square_root_of_6",
      "abs":"of the included two cubes equal to the <em>square</em> <em>roots</em> of the first six natural numbers up to the <em>square</em> <em>root</em> of "
   },
   {
      "title":"Square root of a 2 by 2 matrix",
      "url":"https://en.wikipedia.org/wiki/Square_root_of_a_2_by_2_matrix",
      "abs":"<em>Square</em> <em>roots</em> that are not the all zeros matrix come in pairs if R is a <em>square</em> <em>root</em> of M then R is also a <em>square</em> <em>root</em> of M since R R RR R M A matrix"
   },
   {
      "title":"Root-mean-square deviation",
      "url":"https://en.wikipedia.org/wiki/Root-mean-square_deviation",
      "abs":"<em>Root</em> mean <em>square</em> deviation The <em>root</em> mean <em>square</em> deviation RMSD or <em>root</em> mean <em>square</em> error RMSE is a frequently used measure of the differences between values sample or population values predicted by a model or an estimator and the values observed "
   },
   {
      "title":"Square sign",
      "url":"https://en.wikipedia.org/wiki/Square_sign",
      "abs":"<em>Square</em> sign may refer to The number sign The radical symbol sqrt or used for <em>square</em> <em>root</em> or its precomposed form with a number such as the Unicode characters for the cube <em>root</em> and the fourth <em>root</em> and Any <em>square</em> shaped symbol including many geometrically shaped Unicode"
   },
   {
      "title":"Square root of 3",
      "url":"https://en.wikipedia.org/wiki/Square_root_of_3",
      "abs":"<em>Square</em> <em>root</em> of The <em>square</em> <em>root</em> of is the positive real number that when multiplied by itself gives the number It is denoted mathematically as or / It is more precisely called the principal <em>square</em> <em>root</em> of to distinguish it from the negative number with the same property "
   },
   {
      "title":"Radical symbol",
      "url":"https://en.wikipedia.org/wiki/Radical_symbol",
      "abs":"In linguistics the symbol is used to denote a <em>root</em> word Principal <em>squar</em>"
   },
   {
      "title":"Root mean square",
      "url":"https://en.wikipedia.org/wiki/Root_mean_square",
      "abs":"<em>Root</em> mean <em>square</em> In mathematics and its applications the <em>root</em> mean <em>square</em> RMS or or rms is defined as the <em>square</em> <em>root</em> of the mean <em>square</em> the arithmetic mean of the <em>squares</em> of a set of numbers The RMS is also known as the quadratic mean and is a particular case of the generalized mean with"
   }
]''';
    return SearchResultDTOList((jsonDecode(json) as List)
        .map((e) => SearchResultDTO.fromJson(e))
        .toList());
  }
}
