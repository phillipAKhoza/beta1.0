import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.paragraphs,
    required this.links,
    required this.author,
    required this.publishDate,
  });

  final Widget thumbnail;
  final String title;
  final List<String> paragraphs;
  final List<String> links;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 130,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
          ),
          _ArticleDescription(
            title: title,
            paragraphs: paragraphs,
            links: links,
            author: author,
            publishDate: publishDate,
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
    required this.author,
    required this.publishDate,
  });

  final String title;
  final List<String> paragraphs;
  final List<String> links;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_month_outlined),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
