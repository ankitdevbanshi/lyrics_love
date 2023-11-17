import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/home_page.dart';
import 'package:lyrics_love/pages/admin_page.dart';
import 'package:lyrics_love/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx,snapshot){
          if(snapshot.hasData){
             return AdminPage();
          }
          else{
            return LogInPage();
          }
        },
      ),
    );
  }
}
