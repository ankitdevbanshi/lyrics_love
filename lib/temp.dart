import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/pic1.jpg")),
          ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              // height: 200,
              // width: 200,
              child: Stack(children: [
                BackdropFilter(filter: ImageFilter.blur(sigmaY: 5,sigmaX: 5),child: Container(),),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white54.withOpacity(0.4),
                      Colors.white54.withOpacity(0.1),
                    ])
                  ),
                ),
                SingleChildScrollView(
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
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}


