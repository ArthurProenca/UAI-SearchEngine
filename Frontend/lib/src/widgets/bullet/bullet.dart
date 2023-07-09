import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/search_result_dto.dart';
import 'package:uai/src/service/http_service.dart';

class BulletItem extends StatefulWidget {
  final String title;
  final List<SearchResultDTO> children;
  final String query;

  const BulletItem(this.title, this.children, this.query, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BulletItem();
}

class _BulletItem extends State<BulletItem> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          HttpService.get(Uri.parse("https://en.wikipedia.org/w/api.php"))
              .then((value) {
            widget.children.addAll(value);
          });
        });
      },
      icon: const Icon(Icons.link),
      label: Text(widget.title),
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
}
