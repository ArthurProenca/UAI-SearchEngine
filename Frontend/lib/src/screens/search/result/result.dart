import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/search_result_dto.dart';
import 'package:uai/src/service/http_service.dart';

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
          messages.addAll(value);
        });
      });
    });
  }

  Widget _bullet(String title) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.link),
      label: Text(title),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.orange.shade300),
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
    );
  }

  Widget _buildMessageItem(String message, Alignment alignment, Color color) {
    return SizedBox(
      width: 600,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        alignment: alignment,
        child: Container(
          padding: const EdgeInsets.all(9.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomLeft: alignment == Alignment.topLeft
                  ? const Radius.circular(0.0)
                  : const Radius.circular(15.0),
              bottomRight: alignment == Alignment.topLeft
                  ? const Radius.circular(15.0)
                  : const Radius.circular(0.0),
              topRight: const Radius.circular(15.0),
              topLeft: const Radius.circular(15.0),
            ),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                width: 70,
                height: 70,
                child: Text("HEADER"),
                alignment: Alignment.topLeft,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          if (index == 0) ...[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: _buildMessageItem(
                                messages[index].abs,
                                Alignment.topRight,
                                Colors.orange.shade300,
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                              child: _buildMessageItem(
                                messages[index].abs,
                                Alignment.topLeft,
                                Colors.grey.shade500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: _bullet("Wikipedia"),
                                ),
                                Container(
                                  child: _bullet("SearchOnMath"),
                                ),
                              ],
                            ),
                          ]
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Digite sua mensagem...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Aqui você pode implementar o envio da mensagem para o backend
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
