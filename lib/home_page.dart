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
  List lyrics =
  [{"title":"T1","lyric":"mujhko barsaat bana lo"},
    {"title":"T2","lyric":"mujhko barsaat bana lo"},
    {"title":"T3","lyric":"mujhko barsaat bana lo"},
    {"title":"T4","lyric":"mujhko barsaat bana lo"},
    {"title":"T5","lyric":"mujhko barsaat bana lo"},
    {"title":"T6","lyric":"mujhko barsaat bana lo"},
    {"title":"T7","lyric":"mujhko barsaat bana lo"},
    {"title":"T8","lyric":"mujhko barsaat bana lo"},
    {"title":"T8","lyric":"mujhko barsaat bana lo"},
    {"title":"T10","lyric":"mujhko barsaat bana lo"},
  ];

  FirebaseApp app;

  _HomePageState({required this.app});

  readData(){

   FirebaseDatabase.instanceFor(app: app,
        databaseURL: "https://lyrics-2834d-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("lyrics").once().then((val) {
     // Handle the data
   val.snapshot.children.forEach((element) {
     print(element.value);
   });
   });

  }




  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: TextField(
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
              Expanded(child: ListView.builder(itemCount: 10,itemBuilder: (ctx,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MyListTile(),
                );
              }))
          ],
        ),
      )),
    );
  }
}
