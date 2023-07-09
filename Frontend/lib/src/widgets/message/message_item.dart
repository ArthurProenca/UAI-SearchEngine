import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/search_result_dto.dart';

class MessageItem extends StatefulWidget {
  final String message;
  final bool isUser;
  final List<SearchResultDTO> children;

  const MessageItem(this.message, this.isUser, this.children, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageItem();
}

class _MessageItem extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        alignment: widget.isUser ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.all(9.0),
          decoration: BoxDecoration(
            color:
                widget.isUser ? Colors.orange.shade300 : Colors.grey.shade500,
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
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              Text(
                widget.message,
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
}
