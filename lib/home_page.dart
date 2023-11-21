import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/pages/admin_page.dart';
import 'package:lyrics_love/pages/auth_page.dart';
import 'package:lyrics_love/widgets/hidden_drawer.dart';
import 'package:lyrics_love/widgets/list_tile.dart';
import 'package:lyrics_love/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});
  final FirebaseApp app = Firebase.app();
  @override
  State<HomePage> createState() => _HomePageState(app: app);
}

class _HomePageState extends State<HomePage> {
  List tempLyrics=[];
  List lyrics = [];
  List filterList = [];
@override
  void initState() {
  readData();
    super.initState();
  }

  FirebaseApp app;

  _HomePageState({required this.app});

  readData(){
print("-------------------------read data");
   FirebaseDatabase.instanceFor(app: app,
        databaseURL: "https://lyrics-2834d-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("lyrics").once().then((val) {
     // Handle the data

       tempLyrics=[];
      lyrics=[];
   val.snapshot.children.forEach((element) {
     print("inside for loop");
      print(element.value);
     tempLyrics.add(element.value);
   });
   setState(() {
     lyrics=List.from(tempLyrics);
     filterList=List.from(lyrics);
   });
   });

  }

void searchQuery(String str){
    filterList=[];
    tempLyrics=[];
    lyrics.forEach((element) {
      print("elem------------------------");
      print(element);
      if(element["title"].contains(str)){
        print("inside if ------------------------");
        tempLyrics.add(element);
      }
    }
    );
    setState(() {
      filterList = List.from(tempLyrics);
      print(filterList);
    });
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: TextField(
          onChanged: searchQuery,
            cursorColor:Colors.white54 ,
            style: TextStyle(color: Colors.white54),
            decoration: InputDecoration(
              hintStyle:TextStyle(color: Colors.white54),
              hintText: "search",suffixIcon: Icon(Icons.search,color: Colors.white54,),
            fillColor:Colors.white54,),
        ),
      ),
      drawer: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple,
            Colors.blue
          ])
        ),
        child: NavigationDrawer(
          backgroundColor: Colors.transparent,
          children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListTile(leading: Icon(Icons.person,size: 24,color: Colors.white54,),
              title: Text("admin",style: TextStyle(fontSize: 24,color: Colors.white54,fontWeight: FontWeight.bold),),
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (buildContext){
                   return AuthPage();
                 }));
            },
            ),
          )
        ],),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      bottomNavigationBar: CurvedNavigationBar(
        // animationCurve: Curves.bounceOut,
        onTap: (index){},
         color: Colors.deepPurple.shade50,
          backgroundColor: Colors.deepPurple,
          items: [
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Icons.person)
      ]),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue.shade200,
            Colors.deepPurple.shade200,
          ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // MySearchBar(),
              SizedBox(height: 16,),
              Expanded(child: ListView.builder(itemCount: filterList.length,itemBuilder: (ctx,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MyListTile(imgUrl:filterList[index]["imgUrl"],title: filterList[index]["title"],lyric: filterList[index]["lyric"],
                  hindiLyric:filterList[index]["hindiLyric"]),
                );
              }))
          ],
        ),
      )),
    );
  }
}
