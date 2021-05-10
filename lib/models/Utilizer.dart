import 'package:cloud_firestore/cloud_firestore.dart';

class Utilizer {
  String uid;
  String documentId;
  String name;
  String username;
  int age;
  String photoUrl;

  Utilizer(
      {this.uid,
      this.documentId,
      this.name,
      this.username,
      this.age,
      this.photoUrl});

  factory Utilizer.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Utilizer(
        uid: data['uid'],
        documentId: data['documentId'],
        name: data['name'],
        username: data['username'],
        age: data['age'],
        photoUrl: data['photoUrl']);
  }
  @override
  String toString() {
    return '{ uid: $uid, documentId: $documentId, name: $name, age: $age, username: $username, photoUrl: $photoUrl }';
  }
}
