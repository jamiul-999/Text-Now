import 'package:cloud_firestore/cloud_firestore.dart';

class user_ {
  String uid;
  String documentId;
  String name;
  String username;
  int age;
  String photoUrl;

  user_(
      {this.uid,
      this.documentId,
      this.name,
      this.username,
      this.age,
      this.photoUrl});

  factory user_.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return user_(
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
