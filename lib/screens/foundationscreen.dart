import 'package:flutter/material.dart';
import '../components/custom_list.dart';
import '../dto/visual_dto.dart';

class FoundationScreen extends StatefulWidget {
  const FoundationScreen({super.key});

  @override
  State<FoundationScreen> createState() => _FoundationScreenState();
}

class _FoundationScreenState extends State<FoundationScreen> {
  final FoundatioData foundationData = FoundatioData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Foundations'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: foundationData.foundations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                child: CustomListItem(
                  thumbnail: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            foundationData.foundations[index].image ??
                                'assets/images/logo1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  title: foundationData.foundations[index].title,
                  paragraphs: foundationData.foundations[index].paragraphs,
                  links: foundationData.foundations[index].links ?? [],
                  author: foundationData.foundations[index].author ?? '',
                  publishDate: foundationData.foundations[index].date,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return Foundation(
                        foundation: foundationData.foundations[index]);
                  }));
                },
              ),
            );
          },
        ));
  }
}

class Foundation extends StatelessWidget {
  const Foundation({super.key, required this.foundation});
  final VisualDto foundation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            foundation.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (foundation.image != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          foundation.image ?? 'assets/images/logo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  foundation.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var item in foundation.paragraphs)
                      Text(
                        '\n $item',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    // if (foundation.links.isNotEmpty) const Text('\n'),
                    for (var item in foundation.links ?? [])
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
              )
            ],
          ),
        ));
  }
}
