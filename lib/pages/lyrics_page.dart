import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LyricsPage extends StatelessWidget {
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.deepPurple
          ])
        ),
        child: CurvedNavigationBar(
          // animationCurve: Curves.bounceOut
            onTap: (index){},
              color:Colors.deepPurple.shade50,
             backgroundColor: Colors.transparent,
            items: [
              Icon(Icons.home,color:Colors.deepPurple),
              Icon(Icons.add,color:Colors.deepPurple),
              Icon(Icons.person,color:Colors.deepPurple)
            ]),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network("https://picsum.photos/450/450",fit: BoxFit.cover,)
            ),
            leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);  }),
            title: Text("Tile",maxLines: 1,style: TextStyle(fontSize: 30,overflow: TextOverflow.ellipsis),),
            expandedHeight: 400,
            floating: false,
            // collapsedHeight: 120,
            // toolbarHeight: 90,
          ),
          SliverToBoxAdapter(
            child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.deepPurple,
                Colors.blue
              ])
            ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Text("phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije phir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kije"
                        "phir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kijephir le aya dil rehna dur kya kije"
                        , style:GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 18,
                          color:Colors.white54,
                      height: 2),
                      textAlign: TextAlign.center,
                         ),
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
