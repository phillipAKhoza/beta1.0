import 'package:cloud_firestore/cloud_firestore.dart';

class AddedChat {
  bool isSuccessful;
  String message;
  AddedChat(this.message, this.isSuccessful);
}
class AddToDB{
  Future<AddedChat> addMessage(email,subject,chatMessage) async {
    String message="";
    bool isSuccessful = false;
    try {
      await FirebaseFirestore.instance.collection('chat_db')
          .add({"email": email, "subject": subject, "message":chatMessage})
          .then((documentSnapshot) =>  {isSuccessful =true, message="success"});
    } catch (e) {
      isSuccessful =false; message=e.toString();
    }
    return AddedChat(message,isSuccessful);
  }
  Future<AddedChat> addTechnicalChat(email,chatMessage) async {
    String message="";
    bool isSuccesful = false;
    try {
      await FirebaseFirestore.instance.collection('tech_chat_db')
          .add({"email": email, "message":chatMessage, "subject": ""})
          .then((documentSnapshot) =>  {isSuccesful =true, message="success"});

    } catch (e) {
      isSuccesful =false; message=e.toString();
    }
    return AddedChat(message,isSuccesful);
  }
}