import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StoreService {
  Future<String> uploadImage(File imageFile, String imageId) async {
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(imageId).child("image.jpg");
    StorageUploadTask uploadTask =
        storageRef.child("$imageId").putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downlaodUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downlaodUrl;
  }
}
