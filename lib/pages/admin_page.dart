import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/api/firebase_api.dart';
import 'package:lyrics_love/home_page.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
   AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference lyrics = FirebaseFirestore.instance.collection('lyrics');

  // Future<void> addLyrics() {
  //   // Call the user's CollectionReference to add a new user
  //   return lyrics
  //       .add({
  //     't1': "title1", // John Doe
  //     'l1': "lyrics", // Stokes and Sons
  //   })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  void addLyrics(BuildContext context) async{
    // Call the user's CollectionReference to
    // add a new user
    try {
      FirebaseApp app = Firebase.app();
      final databaseReference = FirebaseDatabase.instanceFor(app: app,
          databaseURL: "https://lyrics-2834d-default-rtdb.asia-southeast1.firebasedatabase.app")
          .ref()
          .child("lyrics");

      await databaseReference.push().set({
        'title': _titleController.text,
        'lyric': _lyricsController.text
      }).whenComplete((){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("uploaded successfully"),
          duration:Duration(seconds: 3) ,));
      });
  }catch(err){
      print(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("upload failed try again"),
    duration:Duration(seconds: 3) ,));
    }
  }


  final formKey = GlobalKey<FormState>();
  File? file;
  String? fileName;
  String titleError='';
  String lyricsError='';
  TextEditingController _lyricsController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  void uploadData(context) async{
     if(formKey.currentState!.validate()){
       print('upload called');
       if(_titleController.text.isEmpty){
         setState(() {
           titleError="please enter title";
         });
         return;
       }
       if(_lyricsController.text.isEmpty){
         setState(() {
           lyricsError = 'please enter lyrics';
         });
         return;
       }
       if(file==null){
         setState(() {
           fileName = 'please choose file';
         });
         return;
       }
       if(file!.path.isEmpty){
         setState(() {
           fileName = 'please choose file';
         });
         return;
       }
            fileName = basename(file!.path);
       final destination = 'files/${fileName}';

       showDialog(context: context, builder: (ctx){
         return Center(child: CircularProgressIndicator());
       });
       final uploadRes =  await FirebaseApi.uploadFile(destination, file!);

       Navigator.pop(context);
       print('------------------------------------------upload-----------------------');

       print(uploadRes!=null?uploadRes:"null");

       addLyrics(context);
       // FirebaseDatabase database = FirebaseDatabase.instance;
       // DatabaseReference ref = FirebaseDatabase.instance.ref("lyrics");
       // await ref.set({
       //   "title": _titleController.text,
       //   "lyric":_lyricsController.text
       // });
     }

  }

  Future selectImg() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg',]);

        if(result==null) return;

        final path = result.files.single.path!;
        setState(() {
          file = File(path);
        });
  }

  void logout(BuildContext context) async {
    showDialog(context: context, builder: (BuildContext ctx){
      return Center(child: CircularProgressIndicator());
    });
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
        return HomePage();
      }));
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error try again"),duration: Duration(seconds: 3),));
    }

  }













  @override
  Widget build(BuildContext context) {

    fileName = file!=null ? file!.path:"No such Image selected";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){logout(context);}, icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue.shade200,
            Colors.deepPurple.shade200
          ])
        ),
        child: Column(
          children: [
            Text("Add Lyrics",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,
                color:Colors.black54 ),),
                SizedBox(height: 32,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (String? value){
                      if(value!.isEmpty){
                        return 'Enter Title';
                      }
                      return null;
                    },
                    controller: _titleController,
                    decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),),
                        hintText: "Title",
                        // errorText: titleError,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))),
                  ),
                  SizedBox(height: 32),

                  TextFormField(
                    validator: (String? value){
                      if(value!.isEmpty){
                        return 'Enter Title';
                      }
                      return null;
                    },
                    controller: _lyricsController,
                    maxLines: 8,
                    decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),),
                        hintText: "lyrics",
                        // errorText: lyricsError,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(onPressed: selectImg, child: Icon(Icons.file_copy),
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),minimumSize: MaterialStateProperty.all(Size(double.maxFinite,8))),
                  ),
                  Text(fileName!),
                  SizedBox(height: 48,),
                  ElevatedButton(onPressed: (){uploadData(context);}, child: Text("upload",style: TextStyle(fontSize: 24),),
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),minimumSize: MaterialStateProperty.all(Size(double.maxFinite,8))),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
