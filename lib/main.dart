
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:lyrics_love/pages/admin_page.dart';
import 'package:lyrics_love/pages/auth_page.dart';
import 'package:lyrics_love/pages/temp.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/home_page.dart';
import 'package:lyrics_love/onboarding_screen.dart';
import 'package:lyrics_love/pages/login_page.dart';
import 'package:lyrics_love/theme/dark_theme.dart';
import 'package:lyrics_love/theme/light_theme.dart';
import 'package:lyrics_love/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.deepPurple.shade500.withOpacity(0.2), // navigation bar color
    statusBarColor: Colors.deepPurple, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final pref = await SharedPreferences.getInstance();
      bool isFirstTime =true;
  if(pref.getBool("first_time")==null){
    isFirstTime = true;
  }
  else{
    isFirstTime = false;
  }

  runApp(
      ChangeNotifierProvider(create: (context)=>ThemeProvider(),
  child: MyApp(isFirstTime:isFirstTime),
  ));
}

class MyApp extends StatelessWidget {

   bool isFirstTime=true;
   MyApp({super.key,required this.isFirstTime});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: Provider.of<ThemeProvider>(context).themeData,
      home: isFirstTime?OnBoardingScreeen():HomePage(),
      // home:AdminPage()
    );
  }
}

// Theme.of(ctx).colorScheme.background

