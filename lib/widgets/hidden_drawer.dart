import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:lyrics_love/pages/auth_page.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    _pages=[
      ScreenHiddenDrawer(ItemHiddenMenu(name: "Admin", baseStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedStyle:TextStyle(fontWeight: FontWeight.bold) ), AuthPage())
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(screens: _pages, backgroundColorMenu: Colors.deepPurple,);
  }
}
