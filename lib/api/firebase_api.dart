

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi{

  static Future<String?> uploadFile(String destination,File file) async{
  try{
    final ref = FirebaseStorage.instance.ref(destination);
   await ref.putFile(file);
   final meta = await ref.getDownloadURL();
   return meta;
  }
  catch(err){
    print(err);
    return null;
  }

  }
}