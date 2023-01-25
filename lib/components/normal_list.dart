import 'package:flutter/material.dart';

class NormalList extends StatelessWidget {
  const NormalList({
    super.key,
    this.image,
    required this.title,
    required this.paragraphs,
    required this.links,
    required this.author,
    required this.publishDate,
  });
  final String? image;
  final String title;
  final List<String> paragraphs;
  final List<String> links;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _ListDescription(
            image: image,
            title: title,
            paragraphs: paragraphs,
            links: links,
            author: author,
            publishDate: publishDate,
          ),
        ),
      ],
    );
  }
}

class _ListDescription extends StatelessWidget {
  const _ListDescription({
    this.image,
    required this.title,
    required this.paragraphs,
    required this.links,
    required this.author,
    required this.publishDate,
  });
  final String? image;
  final String title;
  final List<String> paragraphs;
  final List<String> links;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                paragraphs.first,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                publishDate,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
