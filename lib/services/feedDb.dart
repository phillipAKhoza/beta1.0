import 'package:cloud_firestore/cloud_firestore.dart';
import "../dto/feeddto.dart";

class AddToDB{
   Future<List> addFeed() async {
     List feeds = [];
    String error;
    try {
      await FirebaseFirestore.instance.collection('feed_db')
      .get().then((value) {
            // feeds.map((value) => value);
        value.docs.forEach((element) {
          // print(element.data());
          feeds.add(element.data()) ;
          // print(feeds);
        });
      }
      );
    } catch (e) {
      error = e.toString();
    }
    return feeds;
  }
}