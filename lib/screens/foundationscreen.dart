import 'package:flutter/material.dart';
import '../components/custom_list.dart';
import '../dto/visual_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth.dart';

class FoundationScreen extends StatefulWidget {
  const FoundationScreen({super.key});

  @override
  State<FoundationScreen> createState() => _FoundationScreenState();
}
final FoundationData foundationData = FoundationData();
class _FoundationScreenState extends State<FoundationScreen> {
  late Future<QuerySnapshot> foundationDbCall;
  @override
  void initState(){
    super.initState();
    foundationDbCall = foundationData.foundationsDb.get(const GetOptions(source: Source.cache));
    foundationDbCall.then((value) =>
    {
      if(value.docs.isEmpty){
        foundationDbCall = foundationData.foundationsDb.get(
            const GetOptions(source: Source.server))
      }
    });
  //   const GetOptions(source : Source.cache)
  }
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
          future: foundationDbCall,
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

class Foundation extends StatefulWidget {
  const Foundation({super.key, required this.foundation});
  final DocumentSnapshot foundation;

  @override
  State<Foundation> createState() => _FoundationState();
}

class _FoundationState extends State<Foundation> {
  bool? isAdmin = CurrentUser.getAdminStatus();

  @override
  void initState() {
    super.initState();
    isAdmin = CurrentUser.getAdminStatus();
  }
  @override
  Widget build(BuildContext context) {
    reset(){
      Navigator.pop(context);
    }

    deleteDoc(id) async{
      foundationData.foundationsDb.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feed removed")),
        ),
        reset()
      });
    }
    final List stringParagraph = widget.foundation['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(".,");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.foundation['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.foundation['image'] != null) ...[
                if(widget.foundation['image'].contains("http"))...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.foundation['image']),
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
                        AssetImage(widget.foundation['image'] ?? 'assets/images/logo1.png'),
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
                  widget.foundation['title'],
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
                    for (var item in widget.foundation['links'])
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
              ),
              if(isAdmin == true)...[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed:() => deleteDoc(widget.foundation.id),
                    child: const Text('Delete'),
                  ),
                ),
              ]

            ],
          ),
        ));
  }
}
