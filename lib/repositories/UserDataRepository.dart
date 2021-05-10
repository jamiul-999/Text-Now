import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_now/models/Utilizer.dart';
import 'package:text_now/providers/BaseProviders.dart';
import 'package:text_now/providers/UserDataProvider.dart';

class UserDataRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<Utilizer> saveDetailsFromGoogleAuth(User user) =>
      userDataProvider.saveDetailsFromGoogleAuth(user);

  Future<Utilizer> saveProfileDetails(
          String uid, String profileImageUrl, int age, String username) =>
      userDataProvider.saveProfileDetails(uid, profileImageUrl, age, username);

  Future<bool> isProfileComplete(String uid) =>
      userDataProvider.isProfileComplete(uid);
}
