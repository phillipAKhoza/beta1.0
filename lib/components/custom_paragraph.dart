import 'package:flutter/material.dart';

class CustomParagraphList extends StatelessWidget {
  const CustomParagraphList({
    super.key,
    required this.title,
    required this.paragraphs,
    required this.links,
  });

  final String title;
  final List<String> paragraphs;
  final List<String> links;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: _ArticleDescription(
                title: title,
                paragraphs: paragraphs,
                links: links,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.paragraphs,
    required this.links,
  });

  final String title;
  final List<String> paragraphs;
  final List<String> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var item in paragraphs)
                  Text(
                    '\n $item',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                if (links.isNotEmpty) const Text('\n'),
                for (var item in links)
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
