
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyrics_love/pages/admin_page.dart';

class LogInPage extends StatefulWidget {
   LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String errorMsg = '';
  TextEditingController  _passwordController = TextEditingController();
  TextEditingController  _emailController = TextEditingController();

  void signIn(context) async{
     showDialog(context: context, builder: (ctx){
       return Center(child: CircularProgressIndicator());
     });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return AdminPage();
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
           setState(() {
             errorMsg = "user not found";
           });
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorMsg = "wrong email or password";
        });
        print('Wrong password provided for that user.');
      }else{
      setState(() {
        errorMsg = "try again";
      });}
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.deepPurple,
                    Colors.blue.shade900
                  ])
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0,right: 32,top: 64),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Lyrics",style: GoogleFonts.ubuntu(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),),
                        SizedBox(height: 84,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sign in",style: TextStyle(color: Colors.white54,fontSize: 20),),
                            Text("Sign up",style: TextStyle(color: Colors.white54,fontSize: 20)),
                          ],
                        ),
                      SizedBox(height: 84,),

                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white54),
                        cursorColor: Colors.grey,decoration: InputDecoration(prefixIcon: Icon(Icons.mail,color: Colors.white54,),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54)
                          ),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                      ),
                      ),
                      SizedBox(height: 32,),
                      TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Colors.white54),
                        cursorColor: Colors.grey,decoration: InputDecoration(prefixIcon: Icon(Icons.lock,color: Colors.white54,),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54)
                        ),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                      ),
                      ),
                      SizedBox(height: 24,),
                      SizedBox(height: 24,child: Text(errorMsg,style: TextStyle(color: Colors.red,fontSize: 24),),),
                      SizedBox(height: 24,),
                      GestureDetector(
                        onTap: (){signIn(context);},
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.deepPurple
                          ),
                          child: Center(child: Text("Sign In",style: TextStyle(color: Colors.white54,fontSize: 20),)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
