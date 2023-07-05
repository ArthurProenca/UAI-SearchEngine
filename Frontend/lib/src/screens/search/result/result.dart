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
    ); // Adiciona a primeira mensagem recebida via parâmetro
    // Simula as respostas do backend
    // Aqui você pode substituir por chamadas reais para obter as respostas do backend
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        HttpService.get(Uri.parse("https://en.wikipedia.org/w/api.php"))
            .then((value) {
          messages.addAll(value);
        });
      });
    });
  }

  Widget _buildMessageItem(int index, Alignment alignment, Color color) {
    final message = messages[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Text(
                message.title,
                style: const TextStyle(fontSize: 12.0, color: Colors.white),
              ),
              Text(
                message.abs,
                style: const TextStyle(fontSize: 12.0, color: Colors.white),
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
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _buildMessageItem(
                      index, Alignment.topRight, Colors.blue);
                }
                return _buildMessageItem(index, Alignment.topLeft, Colors.grey);
              },
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
    );
  }
}
