import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dto/messagesDto.dart';
import '../services/auth.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.screen});
  final String screen;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Chat',
                ),
                Tab(
                  text: 'Technical Chat',
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ChatMessage(),
            TechMessage(),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  const ChatMessage({super.key});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  late Future<QuerySnapshot> chatDbCall;
  @override
  void initState(){
    super.initState();
    chatDbCall = ChatData().chatDB.get(const GetOptions(source : Source.cache));
    // .eventsDb.get(const GetOptions(source : Source.cache));
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<QuerySnapshot>(
      future: chatDbCall,
      builder: (BuildContext context,  snapshot){
        if (snapshot.hasData) {

          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          if(documents.isEmpty){
            return const Center(child: Text("No Messages",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),));
          }

          return ListView(
              children: documents
                  .map((doc) =>

                  Card(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              doc['subject'] ?? '',
                              maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                            Text(
                              doc['message'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                            Text(
                              doc['email'] ?? '',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) {
                              return Message(message: doc);
                            }));
                      },
                    ),
                  )).toList()
          );

        }else if (snapshot.hasError) {
          return const Center(child: Text("An Error Occurred!",style: TextStyle(
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
    );
  }
}


class TechMessage extends StatefulWidget {
  const TechMessage({super.key});

  @override
  State<TechMessage> createState() => _TechMessageState();
}

class _TechMessageState extends State<TechMessage> {
  late Future<QuerySnapshot> techChatDbCall;
  @override
  void initState(){
    super.initState();
    techChatDbCall = TchChatData().techChatDB.get(const GetOptions(source : Source.cache));
    // .eventsDb.get(const GetOptions(source : Source.cache));
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: techChatDbCall,
      builder: (BuildContext context,  snapshot){
        if (snapshot.hasData) {

          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          if(documents.isEmpty){
            return const Center(child: Text("No Messages",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),));
          }

          return ListView(
              children: documents
                  .map((doc) =>

                  Card(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              doc['email'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                            Text(
                              doc['message'] ?? '',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) {
                              return Message(message: doc);
                            }));
                      },
                    ),
                  )).toList()
          );

        }else if (snapshot.hasError) {
          return const Center(child: Text("An Error Occurred!",style: TextStyle(
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
    );
  }
}

class Message extends StatefulWidget {
  const Message({super.key,required this.message});
  final DocumentSnapshot message;
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool? isAdmin = CurrentUser.getAdminStatus();
  final ChatData chatData = ChatData();
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
      chatData.chatDB.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Message removed")),
        ),
        reset()
      });
    }
    final String stringMessage= widget.message['message'];
    final String subject = widget.message['subject'];
    final String userEmail = widget.message['email'];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Message'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if(subject.isNotEmpty)...[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                      subject ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    )),
              )],
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                      userEmail ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                      stringMessage ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    )),
              ),
              if(isAdmin == true)...[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed:() => deleteDoc(widget.message.id),
                    child: const Text('Delete'),
                  ),
                ),
              ]
            ],
          ),
        ));
  }
}



