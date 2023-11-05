import 'package:cloud_firestore/cloud_firestore.dart';
import "../dto/feeddto.dart";

class AddedFeed {
  bool isSuccesful;
  String message;
  AddedFeed(this.message, this.isSuccesful);
}
class AddToDB{
    Future<AddedFeed> addFeed(title,image,author,date,paragraphs,links) async {
     // List feeds = feed;
      String message="";
      bool isSuccesful = false;
    try {
      await FirebaseFirestore.instance.collection('feed_db')
          .add({"title": title,"image": image,"author":title,"date": date,"paragraphs":paragraphs,"links":links})
          .then((documentSnapshot) =>  {isSuccesful =true, message="success"});
          print(isSuccesful);

    } catch (e) {
      isSuccesful =false; message=e.toString();
      print("$message here...");
    }
    return AddedFeed(message,isSuccesful);
  }
}