import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LyricsPage extends StatefulWidget {
  String lyric;
  String title;
  String imgUrl;
  String hindiLyric;
   LyricsPage({required this.hindiLyric,required this.imgUrl,required this.title,required this.lyric,super.key});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  bool isEngLan=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(colors: [
      //       Colors.blue,
      //       Colors.deepPurple
      //     ])
      //   ),
      //   child: CurvedNavigationBar(
      //     // animationCurve: Curves.bounceOut
      //       onTap: (index){},
      //         color:Colors.deepPurple.shade50,
      //        backgroundColor: Colors.transparent,
      //       items: [
      //         Icon(Icons.home,color:Colors.deepPurple),
      //         Icon(Icons.add,color:Colors.deepPurple),
      //         Icon(Icons.person,color:Colors.deepPurple)
      //       ]),
      // ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.withOpacity(0.8),
                  Colors.blue.withOpacity(0.8)
                ])
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black54.withOpacity(0.3), BlendMode.srcATop),
                    child: Image.network(widget.imgUrl,fit: BoxFit.cover,)
                )
              ),
              leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);  }),
              actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, // Set background color to transparent
                            onPrimary: Colors.white,),
                      onPressed: () {
                      setState(() {
                      isEngLan = !isEngLan;
                      });
                      },
                   child: Text(isEngLan ? 'English' : 'Hindi'),
                      )

              ],
              title: Text(widget.title,maxLines: 1,style: TextStyle(fontSize: 30,overflow: TextOverflow.ellipsis),),
              expandedHeight: 400,
              floating: false,
              // collapsedHeight: 120,
              // toolbarHeight: 90,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 32),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.white54.withOpacity(0.3),
                          Colors.white54.withOpacity(0.1),
                        ]),
                        // color: Colors.red
                      ),
                      child: Stack(children: [
                        BackdropFilter(filter: ImageFilter.blur(sigmaY: 5,sigmaX: 5),child: Container(),),
                        SingleChildScrollView(
                          child: Center(
                            child: Text(isEngLan?widget.lyric:widget.hindiLyric,style:GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 18,
                                  color:Colors.white54,
                                  height: 2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
