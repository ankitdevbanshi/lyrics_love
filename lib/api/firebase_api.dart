

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi{
  static String getContentType(String fileExtension) {
    // Create a mapping between file extensions and content types
    Map<String, String> contentTypeMap = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
    };
    return contentTypeMap[fileExtension.toLowerCase()] ?? 'application/octet-stream';
  }
  static Future<String?> uploadFile(String destination,File file) async{
  try{
    print("---------------------destination");
    print(destination);
    String fileExtension = destination.split('.').last;
    String contentType = getContentType(fileExtension);
    print(contentType);
    final ref = FirebaseStorage.instance.ref(destination);
   await ref.putFile(file);
    final newMetadata = SettableMetadata(
      cacheControl: "public,max-age=300",
      contentType: contentType,
    );
    await ref.updateMetadata(newMetadata);
   final meta  = await ref.getMetadata();
   print("----------------------meta");
   print(meta.contentType);
   final url = await ref.getDownloadURL();
   return url;
  }
  catch(err){
    print(err);
    return null;
  }

  }
}