import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_now/models/Utilizer.dart';

abstract class BaseAuthenticationProvider {
  Future<User> signInWithGoogle();
  Future<void> signOutUser();
  Future<User> getCurrentUser();
  Future<bool> isLoggedIn();
}

abstract class BaseUserDataProvider {
  Future<Utilizer> saveDetailsFromGoogleAuth(User user);
  Future<Utilizer> saveProfileDetails(
      String uid, String profileImageUrl, int age, String username);
  Future<bool> isProfileComplete(String uid);
}

abstract class BaseStorageProvider {
  Future<String> uploadImage(File file, String path);
}
