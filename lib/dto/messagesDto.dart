import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  CollectionReference chatDB = FirebaseFirestore.instance.collection('chat_db');
}
class TchChatData {
  CollectionReference techChatDB = FirebaseFirestore.instance.collection('tech_chat_db');
}