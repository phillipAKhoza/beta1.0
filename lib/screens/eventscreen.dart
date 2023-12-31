import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/normal_list.dart';
import '../dto/visual_dto.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}
final EventData eventData = EventData();
class _EventsScreenState extends State<EventsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Church Events'),
          automaticallyImplyLeading: false,
        ),
        body:

        FutureBuilder<QuerySnapshot>(
          future: eventData.eventsDb.get(),
          builder: (BuildContext context,  snapshot){
          if (snapshot.hasData) {

            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            if(documents.isEmpty){
              return const Center(child: Text("No Events",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),));
            }

            return ListView(
                children: documents
                    .map((doc) =>

                   Card(
                  child: InkWell(
                    child: NormalList(
                      title: doc['title'] ?? '',
                      paragraphs: List<String>.from(doc['paragraphs']),
                      links:  List<String>.from(doc['links']),
                      author: doc['author'] ?? '',
                      publishDate: doc['date'] ?? '',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) {
                            return Event(event: doc);
                          }));
                    },
                  ),
                )).toList()
            );

          }else if (snapshot.hasError) {
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

class Event extends StatelessWidget {
  const Event({super.key, required this.event});
  // final VisualDto event;
  final DocumentSnapshot event;
  @override
  Widget build(BuildContext context) {
    reset(){
      Navigator.pop(context);
    }

    deleteDoc(id) async{
      eventData.eventsDb.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feed removed")),
        ),
        reset()
      });
    }
    final List stringParagraph = event['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(".,");
    final List stringLinks = event['links'];
    final List<String> links = stringLinks[0].split('.,');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Event'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (event['image'] != null) ...[
                if(event['image'].contains("http"))...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(event['image']),
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
                        AssetImage(event['image'] ?? 'assets/images/logo1.png'),
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
                      event['title'] ?? '',
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
                    if (event['links'] != null) const Text('\n'),
                    for (var item in links)
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                    if (event['author'] != null)
                      Text(
                        event['author'] ?? '',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      'Event Date: ${event['date']}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed:() => deleteDoc(event.id),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ));
  }
}
