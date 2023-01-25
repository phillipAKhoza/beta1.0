import 'package:flutter/material.dart';
import '../components/custom_paragraph.dart';
import '../dto/legalities_dto.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final PrivacyData privacyData = PrivacyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Privacy Policy'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: privacyData.polocies.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomParagraphList(
              title: privacyData.polocies[index].title,
              paragraphs: privacyData.polocies[index].paragraphs,
              links: privacyData.polocies[index].links,
            );
          },
        ));
  }
}
