import 'package:flutter/material.dart';
import '../components/normal_list.dart';
import '../dto/visual_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}
final NotificationData notificationData = NotificationData();
class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notifications'),
          automaticallyImplyLeading: false,
        ),
        body:
        FutureBuilder<QuerySnapshot>(
          future: notificationData.notificationsDb.get(),
          builder: (BuildContext context,  snapshot){
            if (snapshot.hasData) {

              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              if(documents.isEmpty){
                return const Center(child: Text("No Notifications",style: TextStyle(
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
                                  return Notification(notification: doc);
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

class Notification extends StatelessWidget {
  const Notification({super.key, required this.notification});
  final DocumentSnapshot notification;

  @override
  Widget build(BuildContext context) {
    reset(){
      Navigator.pop(context);
    }

    deleteDoc(id) async{
      notificationData.notificationsDb.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feed removed")),
        ),
        reset()
      });
    }
    final List stringParagraph = notification['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(".,");
    // final List stringLinks = notification['links'];
    // final List<String> links = stringLinks[0].split('.,');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notification'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (notification['image'] != null) ...[
                if(notification['image'].contains("http"))...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(notification['image']),
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
                        AssetImage(notification['image'] ?? 'assets/images/logo1.png'),
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
                  notification['title'],
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
                    // if (notification.links.isNotEmpty) const Text('\n'),
                    for (var item in notification['links'] ?? [])
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                    if (notification['author'] != null)
                      Text(
                        notification['author'] ?? '',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      notification['date'],
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
                  onPressed:() => deleteDoc(notification.id),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ));
  }
}
