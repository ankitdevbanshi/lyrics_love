import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/intro%20screens/intro_page_1.dart';
import 'package:lyrics_love/intro%20screens/intro_page_2.dart';
import 'package:lyrics_love/intro%20screens/intro_page_3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_page.dart';

class OnBoardingScreeen extends StatefulWidget {
  const OnBoardingScreeen({super.key});

  @override
  State<OnBoardingScreeen> createState() => _OnBoardingScreeenState();
}

class _OnBoardingScreeenState extends State<OnBoardingScreeen> {
  PageController _controller = PageController();
   bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          PageView(
            onPageChanged: (index){

                setState(() {
                  onLastPage=index==2?true:false;
                });

            },
          controller: _controller,
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),


              Container(
                  alignment: Alignment(0,0.75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap:(){
                            _controller.jumpToPage(2);
                          },
                          child: Text("skip",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                      SmoothPageIndicator(controller: _controller, count: 3),

                      !onLastPage?GestureDetector(
                          child: Text("next",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                           onTap: (){
                            _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                        },
                      ):
                      GestureDetector(
                        child: Text("done",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        onTap: () async{
                          final pref = await SharedPreferences.getInstance();
                          pref.setBool("first_time", false);
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return HomePage();
                          }));
                        },
                      )
                    ],
                  )
              ),

    ]
      ),
    );
  }
}
