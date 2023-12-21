import 'package:cloud_firestore/cloud_firestore.dart';

class AddedStream {
  bool isSuccessful;
  String message;
  AddedStream(this.message, this.isSuccessful);
}
class AddToDB{
  Future<AddedStream> addSermonStream(url) async {
    // List feeds = feed;
    //  List<dynamic> feeds =[];
    String message="";
    bool isSuccessful = false;
    try {
      await FirebaseFirestore.instance.collection('sermonStream_db')
          .add({"url": url})
          .then((documentSnapshot) =>  {isSuccessful =true, message="success"});
    } catch (e) {
      isSuccessful =false; message=e.toString();
    }
    return AddedStream(message,isSuccessful);
  }
  Future<AddedStream> addKidsStream(url) async {
    // List feeds = feed;
    String message="";
    bool isSuccesful = false;
    try {
      await FirebaseFirestore.instance.collection('kidsStream_db')
          .add({"url": url})
          .then((documentSnapshot) =>  {isSuccesful =true, message="success"});

    } catch (e) {
      isSuccesful =false; message=e.toString();
    }
    return AddedStream(message,isSuccesful);
  }
}