
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
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
  final formKey = GlobalKey<FormState>();
  File? thumbFile;
  String hindiText="";
  File? hindiFile;
  File? EngFile;
  String EngText="";
  Text fileName=Text("No such Image selected");
  String titleError='';
  String lyricsError='';
  TextEditingController _lyricsController = TextEditingController();
  TextEditingController _lyricsHindiController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

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

  void addLyrics(BuildContext context,String imgUrl) async{
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
        'lyric': _lyricsController.text,
        'hindiLyric': _lyricsHindiController.text,
        "imgUrl":imgUrl
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
           lyricsError = 'please enter English lyrics';
         });
         return;
       }
       if(thumbFile==null){
         setState(() {
           fileName = Text('please choose file',style: TextStyle(color: Colors.red),);
         });
         return;
       }
       if(thumbFile!.path.isEmpty){
         setState(() {
           fileName = Text('please choose file',style: TextStyle(color: Colors.red),);
         });
         return;
       }
            fileName = Text(thumbFile!.path);
       final destination = 'files/${thumbFile!.path}';

       showDialog(context: context, builder: (ctx){
         return Center(child: CircularProgressIndicator());
       });
       final url =  await FirebaseApi.uploadFile(destination, thumbFile!);

       if(url==null){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image upload failed try again"),
           duration:Duration(seconds: 3) ,));
         Navigator.pop(context);
         return;
       }
       Navigator.pop(context);
       print('------------------------------------------upload-----------------------');

       // print(url!=null?uploadRes:"null");

       addLyrics(context,url);

     }

  }

  Future selectImg(String type) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg',]);

        if(result==null) return;

        final path = result.files.single.path!;
        if(type=="THUMB"){
          setState(() {
            thumbFile = File(path);
            fileName = Text(thumbFile!.path);
          });

        }
        else if(type=="ENG"){
          setState(() {
            EngFile = File(path);
          });
          getEngText();
        }
        else if(type=="HINDI"){
          setState(() {
            hindiFile = File(path);
          });
          getHindiText();
        }

  }

  void getEngText() async{

    final inputImage = InputImage.fromFilePath(EngFile!.path);
    final textRecogniser = GoogleMlKit.vision.textRecognizer();
    final processedImg = await textRecogniser.processImage(inputImage);
    await textRecogniser.close();
    EngText="";
    for(TextBlock tb in processedImg.blocks){
      for(TextLine tl in tb.lines){
        EngText = EngText+tl.text+"\n";
      }
    }
    print("------------------------------------------------------------------");
    _lyricsController.text=EngText;
   print(EngText);
  }



  void getHindiText() async{
try{
  print("get hindi img called------------------------------------------------------");
  final inputImage = InputImage.fromFilePath(hindiFile!.path);
  final textRecogniser = TextRecognizer(script: TextRecognitionScript.devanagiri);
  final processedImg = await textRecogniser.processImage(inputImage);
  await textRecogniser.close();
  hindiText="";
  for(TextBlock tb in processedImg.blocks){
    for(TextLine tl in tb.lines){
      hindiText = hindiText+tl.text+"\n";
    }
  }
  print("------------------------------------------------------------------");
  _lyricsHindiController.text=hindiText;
  print(hindiText);
}catch(error,stackTrace){
  print(stackTrace);
}

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
        child: SingleChildScrollView(
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
                          return 'Enter English lyrics';
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

                    TextFormField(
                      // validator: (String? value){
                      //   if(value!.isEmpty){
                      //     return 'Enter Hindi lyrics';
                      //   }
                      //   return null;
                      // },
                      controller: _lyricsHindiController,
                      maxLines: 8,
                      decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),),
                          hintText: "Hindi lyrics (optional)",
                          // errorText: lyricsError,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))),
                    ),

                    SizedBox(height: 32),
                    ElevatedButton(onPressed: (){selectImg("ENG");}, child:Text("select Eng. text image"),
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),minimumSize: MaterialStateProperty.all(Size(double.maxFinite,8))),
                    ),

                    ElevatedButton(onPressed: (){selectImg("HINDI");}, child:Text("select Hindi text image"),
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),minimumSize: MaterialStateProperty.all(Size(double.maxFinite,8))),
                    ),
                    ElevatedButton(onPressed: (){selectImg("THUMB");}, child: Text("select Thumbnail image"),
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),minimumSize: MaterialStateProperty.all(Size(double.maxFinite,8))),
                    ),
                    fileName,
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
      ),
    );
  }
}
