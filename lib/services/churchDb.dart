import 'package:cloud_firestore/cloud_firestore.dart';

class AddedToChurch {
  bool isSuccessful;
  String message;
  AddedToChurch(this.message, this.isSuccessful);
}
class AddToDB{
  Future<AddedToChurch> addMinistry(church,leaders,address,paragraphs,contacts) async {
    // List feeds = feed;
    //  List<dynamic> feeds =[];
    String message="";
    bool isSuccessful = false;
     List<String> listParagraphs = paragraphs.split(".,");
     List<String> listContacts = contacts.split(".,");
    try {
      await FirebaseFirestore.instance.collection('ministry_db')
          .add({"church": church,"leaders": leaders,"address":address,"paragraphs": listParagraphs,"contacts":listContacts})
          .then((documentSnapshot) =>  {isSuccessful =true, message="success"});
    } catch (e) {
      isSuccessful =false; message=e.toString();
    }
    return AddedToChurch(message,isSuccessful);
  }
  Future<AddedToChurch> addLocation(church,leaders,address,paragraphs,contacts) async {
    // List feeds = feed;
    //  List<dynamic> feeds =[];
    String message="";
    bool isSuccessful = false;
    final List<String> listParagraphs = paragraphs.split(".,");
    final List<String> listContacts = contacts.split(".,");
    try {
      await FirebaseFirestore.instance.collection('location_db')
          .add({"church": church,"leaders": leaders,"address":address,"paragraphs": listParagraphs,"contacts":listContacts})
          .then((documentSnapshot) =>  {isSuccessful =true, message="success"});
    } catch (e) {
      isSuccessful =false; message=e.toString();
    }
    return AddedToChurch(message,isSuccessful);
  }
  // Future<AddedFeed> addFoundation(title,image,author,date,paragraphs,links) async {
  //   // List feeds = feed;
  //   String message="";
  //   bool isSuccesful = false;
  //   try {
  //     await FirebaseFirestore.instance.collection('foundation_db')
  //         .add({"title": title,"image": image,"author":title,"date": date,"paragraphs":paragraphs,"links":links})
  //         .then((documentSnapshot) =>  {isSuccesful =true, message="success"});
  //
  //   } catch (e) {
  //     isSuccesful =false; message=e.toString();
  //   }
  //   return AddedFeed(message,isSuccesful);
  // }
  // Future<AddedFeed> addNotification(title,image,author,date,paragraphs,links) async {
  //   // List feeds = feed;
  //   String message="";
  //   bool isSuccesful = false;
  //   try {
  //     await FirebaseFirestore.instance.collection('notification_db')
  //         .add({"title": title,"image": image,"author":title,"date": date,"paragraphs":paragraphs,"links":links})
  //         .then((documentSnapshot) =>  {isSuccesful =true, message="success"});
  //
  //   } catch (e) {
  //     isSuccesful =false; message=e.toString();
  //   }
  //   return AddedFeed(message,isSuccesful);
  // }
  // Future<AddedFeed> addEvent(title,image,author,date,paragraphs,links) async {
  //   // List feeds = feed;
  //   String message="";
  //   bool isSuccesful = false;
  //   try {
  //     await FirebaseFirestore.instance.collection('event_db')
  //         .add({"title": title,"image": image,"author":title,"date": date,"paragraphs":paragraphs,"links":links})
  //         .then((documentSnapshot) =>  {isSuccesful =true, message="success"});
  //
  //   } catch (e) {
  //     isSuccesful =false; message=e.toString();
  //   }
  //   return AddedFeed(message,isSuccesful);
  // }
}