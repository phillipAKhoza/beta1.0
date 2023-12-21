import 'package:cloud_firestore/cloud_firestore.dart';
class SermonStreamData{
  CollectionReference sermonStreamDb = FirebaseFirestore.instance.collection('sermonStream_db');
}
class KidsStreamData{
  CollectionReference kidsStreamDb = FirebaseFirestore.instance.collection('kidsStream_db');
}
