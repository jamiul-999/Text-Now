import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:text_now/providers/BaseProviders.dart';

class StorageProvider extends BaseStorageProvider {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  Future<String> uploadImage(File file, String path) async {
    Reference reference = firebaseStorage.ref().child(path);
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot result = await uploadTask;
    String url = await result.ref.getDownloadURL();
    print(url);
    return url;
  }
}
