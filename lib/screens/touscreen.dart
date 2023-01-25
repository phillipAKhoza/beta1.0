import 'package:flutter/material.dart';
import '../components/custom_paragraph.dart';
import '../dto/legalities_dto.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  final TermsData tnc = TermsData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Terms of use'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: tnc.tsncs.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomParagraphList(
            title: tnc.tsncs[index].title,
            paragraphs: tnc.tsncs[index].paragraphs,
            links: tnc.tsncs[index].links,
          );
        },
      ),
    );
  }
}
