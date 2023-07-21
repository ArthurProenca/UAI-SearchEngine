import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/search_result_dto.dart';
import 'package:uai/src/screens/home/home.dart';
import 'package:uai/src/service/http/http_service.dart';
import 'package:uai/src/widgets/message/message_item.dart';
import 'package:uai/src/widgets/typing/typing.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SearchResult extends StatelessWidget {
  static const String route = '/result';

  const SearchResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String query = ModalRoute.of(context)!.settings.arguments.toString();
    return MaterialApp(
      title: "Resultados",
      home: SearchResultPage(query),
      routes: {
        SearchResult.route: (context) => const SearchResult(),
        SearchForm.route: (context) => const SearchForm(),
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

  bool isLoading = true;

  String query = "";
  List<SearchResultDTO> messages = [];

  @override
  void initState() {
    super.initState();
    messages.add(
      SearchResultDTO("Usuário", widget.query, "", true),
    );

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        HttpService.get(Uri.parse("https://en.wikipedia.org/w/api.php"))
            .then((value) {
          isLoading = false;
          messages.addAll(value);
        });
      });
    });
  }

  Widget buttonLogic(String title, List<SearchResultDTO> children) {
    if (messages.length == 1) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              HttpService.get(Uri.parse("https://web.whatsapp.com/"))
                  .then((value) {
                List<SearchResultDTO> x = [];

                children.add(new SearchResultDTO(
                    "Usuário", "https://web.whatsapp.com/", "", true));

                //  children.addAll(value);
              });
            });
          },
          icon: const Icon(Icons.link),
          label: Text(title),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(188, 252, 201, 16)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            iconSize: MaterialStateProperty.all<double>(15),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff282c34),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SearchForm.route, arguments: "");
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: isLoading
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: TypingAnimationWidget(
                            text: "",
                            duration: const Duration(milliseconds: 500),
                          ),
                        )
                      : ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                if (index == 0) ...[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: MessageItem(
                                      messages[0].abs,
                                      true,
                                      List.empty(),
                                    ),
                                  ),
                                ] else ...[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    child: InkWell(
                                      onTap: () {
                                        launchUrlString(messages[index].url);
                                      },
                                      child: MessageItem(
                                        messages[index].abs,
                                        false,
                                        messages,
                                      ),
                                    ),
                                  ),
                                  if (index == messages.length - 1) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              27, 0, 10, 0),
                                          child: buttonLogic(
                                              "Wikipedia", messages),
                                        ),
                                        buttonLogic("SearchOnMath", messages),
                                      ],
                                    ),
                                  ],
                                ]
                              ],
                            );
                          },
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                      color:
                          Colors.grey), // Definindo a cor do texto para branco
                  decoration: const InputDecoration(
                    focusColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    suffixIcon: Icon(
                        color: Color.fromARGB(188, 252, 201, 16), Icons.send),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
