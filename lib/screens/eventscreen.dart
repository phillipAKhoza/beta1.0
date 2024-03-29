import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/normal_list.dart';
import '../dto/visual_dto.dart';
import '../services/auth.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}
final EventData eventData = EventData();
class _EventsScreenState extends State<EventsScreen> {
  late Future<QuerySnapshot> eventDbCall;
  @override
  void initState(){
    super.initState();
    eventDbCall = eventData.eventsDb.get();
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
          title: const Text('Church Events'),
          automaticallyImplyLeading: false,
        ),
        body:

        FutureBuilder<QuerySnapshot>(
          future: eventDbCall,
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

class Event extends StatefulWidget {
  const Event({super.key, required this.event});
  // final VisualDto event;
  final DocumentSnapshot event;

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
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
      eventData.eventsDb.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feed removed")),
        ),
        reset()
      });
    }
    final List stringParagraph = widget.event['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(".,");
    final List stringLinks = widget.event['links'];
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
              if (widget.event['image'] != null) ...[
                if(widget.event['image'].contains("http"))...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.event['image']),
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
                        AssetImage(widget.event['image'] ?? 'assets/images/logo1.png'),
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
                      widget.event['title'] ?? '',
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
                    if (widget.event['links'] != null) const Text('\n'),
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
                    if (widget.event['author'] != null)
                      Text(
                        widget.event['author'] ?? '',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      'Event Date: ${widget.event['date']}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
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
                    onPressed:() => deleteDoc(widget.event.id),
                    child: const Text('Delete'),
                  ),
                ),
              ]
            ],
          ),
        ));
  }
}
