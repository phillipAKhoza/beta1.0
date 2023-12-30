import 'package:flutter/material.dart';
import '../components/custom_list.dart';
import '../dto/visual_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoundationScreen extends StatefulWidget {
  const FoundationScreen({super.key});

  @override
  State<FoundationScreen> createState() => _FoundationScreenState();
}

class _FoundationScreenState extends State<FoundationScreen> {
  final FoundationData foundationData = FoundationData();

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
        body:
        FutureBuilder<QuerySnapshot>(
          future: foundationData.foundationsDb.get(),
          builder: (BuildContext context,  snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              if(documents.isEmpty){
                return const Center(child: Text("No Foundation data",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),));
              }
              return SizedBox(
                height: 550,
                child: ListView(
                    children: documents
                        .map((doc) => Card(
                      child: InkWell(
                        child: CustomListItem(
                          thumbnail: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: doc['image'].contains("http") ? NetworkImage(doc['image']) : AssetImage( doc['image'] ?? 'assets/images/logo1.png') as ImageProvider,
                                  fit: BoxFit.contain,
                                  ),
                            ),
                          ),
                          title: doc['title'],
                          paragraphs: [],
                          links: [],
                          author: '',
                          publishDate: '',
                                  ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) {
                                return Foundation(foundation: doc);
                              }));
                        },
                      ),
                    )).toList()),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("It's Error!",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),));
            }
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}

class Foundation extends StatelessWidget {
  const Foundation({super.key, required this.foundation});
  final DocumentSnapshot foundation;
  @override
  Widget build(BuildContext context) {
    final List stringParagraph = foundation['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(".,");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            foundation['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (foundation['image'] != null) ...[
                if(foundation['image'].contains("http"))...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(foundation['image']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ]else ...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        AssetImage(foundation['image'] ?? 'assets/images/logo1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ],
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  foundation['title'],
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
                    // if (foundation.links.isNotEmpty) const Text('\n'),
                    for (var item in foundation['links'])
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
