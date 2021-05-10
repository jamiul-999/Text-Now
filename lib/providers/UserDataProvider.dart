import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_now/config/Paths.dart';
import 'package:text_now/models/Utilizer.dart';
import 'package:text_now/providers/BaseProviders.dart';
import 'dart:core';
//import 'package:text_now/repositories/UserDataRepository.dart';
//import 'package:firebase_core/firebase_core.dart';

class UserDataProvider extends BaseUserDataProvider {
  final fireStoreDb = FirebaseFirestore.instance;

  @override
  Future<Utilizer> saveDetailsFromGoogleAuth(User user) async {
    DocumentReference ref =
        fireStoreDb.collection(Paths.usersPath).doc(user.uid); //user reference
    final bool userExists = await ref.snapshots().isEmpty;
    var data = {
      //add details received from google auth
      'uid': user.uid,
      'email': user.email,
      'name': user.displayName,
      //'photoUrl': user.photoURL,
    };
    if (!userExists && user.photoURL != null) {
      data['photoUrl'] = user.photoURL;
    }
    ref.set(data);
    SetOptions(merge: true);
    final DocumentSnapshot currentDocument = await ref.get();
    //return User.fromFirestore(currentDocument);
    return Utilizer.fromFirestore(currentDocument);
  }

  @override
  Future<Utilizer> saveProfileDetails(
      String uid, String profileImageUrl, int age, String username) async {
    DocumentReference ref =
        fireStoreDb.collection(Paths.usersPath).doc(uid); //user reference
    var data = {
      'photoUrl': profileImageUrl,
      'age': age,
      'username': username,
    };
    //ref.setData(data, merge: true);
    ref.set(data);
    SetOptions(merge: true);
    final DocumentSnapshot currentDocument = await ref.get();
    return Utilizer.fromFirestore(currentDocument);
  }

  @override
  Future<bool> isProfileComplete(String uid) async {
    DocumentReference ref = fireStoreDb.collection(Paths.usersPath).doc(uid);
    final DocumentSnapshot currentDocument = await ref.get();

    return (currentDocument.exists &&
        currentDocument.data.containsKey('username') &&
        currentDocument.data.containsKey('age'));
  }
}
