import 'package:flutter/material.dart';
import '../dto/dto-barrel.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  final BibleData bibleData = BibleData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Bible'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(1),
        itemCount: bibleData.books.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child: Text(
                  bibleData.books[index].name,
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return Book(book: bibleData.books[index]);
              }));
            },
          );
        },
      ),
    );
  }
}

class Book extends StatelessWidget {
  const Book({super.key, required this.book});
  final BibleDto book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(book.name),
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 5,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(book.chapters.length, (index) {
          return InkWell(
            child: Card(
              child: Center(
                child: Text(
                  '${index + 1}',
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return Verses(book: book.chapters[index], title: book.name);
              }));
            },
          );
        }),
      ),
    );
  }
}

class Verses extends StatelessWidget {
  const Verses({super.key, required this.book, required this.title});
  final List<String> book;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(1),
        itemCount: book.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              ' ${index + 1}. ${book[index]}',
              style: const TextStyle(
                fontSize: 17.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
