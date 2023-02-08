import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:messenger/constants/routes.dart';

class FirebaseStorageService {
  static FirebaseStorage? storage;
  static final FirebaseStorageService _instance =
      FirebaseStorageService._internal();

  factory FirebaseStorageService() {
    return _instance;
  }

  FirebaseStorageService._internal();

  Future<void> init() async {
    storage = FirebaseStorage.instance;
  }

  Future<String?> upload({
    required File file,
    required String key,
    String type = ".jpg",
  }) async {
    var ref = storage?.ref("${Routes.userImages}$key$type");
    try {
      var result = await ref?.putFile(file);
      return result?.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      log(e.toString(), error: e);
    }
    return null;
  }
}
