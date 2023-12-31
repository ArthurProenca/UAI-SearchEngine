import 'package:flutter/material.dart';
import 'package:uai/src/domain/messages/messages.dart';

class MessageItem extends StatefulWidget {
  final String message;
  final bool isUser;
  final List<Messages> children;

  const MessageItem(this.message, this.isUser, this.children, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageItem();
}

TextSpan _parseText(MessageItem messageItem) {
  final message = messageItem.message;
  final List<InlineSpan> children = [];

  final List<String> parts = message.split(RegExp(r'<em>|<\/em>'));
  bool isEmph = message.startsWith('<em>');

  for (int i = 0; i < parts.length; i++) {
    if (isEmph) {
      children.add(TextSpan(
        text: parts[i],
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(188, 252, 201, 16),
          fontFamily: 'Quicksand regular',
        ),
      ));
    } else {
      children.add(TextSpan(
        text: parts[i],
        style: TextStyle(
          color: messageItem.isUser ? Colors.white : Colors.grey,
          fontFamily: 'Quicksand regular',
        ),
      ));
    }

    isEmph = !isEmph;
  }

  return TextSpan(children: children);
}

class _MessageItem extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Row(
        // Utilizando um Row para colocar o ícone e o Container principal lado a lado
        children: [
          if (!widget.isUser) ...[
            Icon(
              // Ícone com a letra "W"
              Icons.search,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(width: 5.0),
          ], // Espaçamento entre o ícone e o Container principal
          Expanded(
            // O Expanded é utilizado para permitir que o Container principal ocupe todo o espaço restante
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              alignment: widget.isUser ? Alignment.topRight : Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(9.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    if (!widget.isUser) ...[
                      BoxShadow(
                        blurStyle: BlurStyle.outer,
                        color: Colors.black.withOpacity(0.13),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ],
                  color: widget.isUser
                      ? const Color.fromARGB(188, 252, 201, 16)
                      : const Color.fromARGB(255, 68, 70, 75),
                  borderRadius: BorderRadius.only(
                    bottomLeft: !widget.isUser
                        ? const Radius.circular(0.0)
                        : const Radius.circular(17.0),
                    bottomRight: !widget.isUser
                        ? const Radius.circular(17.0)
                        : const Radius.circular(0.0),
                    topRight: const Radius.circular(17.0),
                    topLeft: const Radius.circular(17.0),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  padding: EdgeInsets.all(7),
                  child: RichText(
                    text: _parseText(widget),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
