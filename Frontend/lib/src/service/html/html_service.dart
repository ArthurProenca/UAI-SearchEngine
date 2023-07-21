import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart' as html_parser;

class HtmlService extends StatefulWidget {
  final String htmlText;
  const HtmlService(this.htmlText, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HtmlServiceState();
}

class HtmlServiceState extends State<HtmlService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Renderização de HTML'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          // Usando o widget Html para renderizar o HTML
          child: Html(
            data: widget.htmlText,
            // Mapeando as tags para seus respectivos widgets em Flutter
            customRender: (node, children) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case 'em':
                    // Tag <em> para texto em itálico
                    return Text(
                      node.text,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    );
                  case 'h1':
                    // Tag <h1> para cabeçalho com tamanho maior
                    return Text(
                      node.text,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  case 'p':
                    // Tag <p> para parágrafo
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(node.text),
                    );
                  case 'b':
                    // Tag <b> para texto em negrito
                    return Text(
                      node.text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                }
              }
              return null;
            },
            customParser: html_parser.HtmlParser(
              // Lida com tags desconhecidas
              customRender: (node, children) {
                // Você pode implementar aqui como renderizar as tags não mapeadas
                // Retornando null aqui, elas serão tratadas pelo comportamento padrão
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
