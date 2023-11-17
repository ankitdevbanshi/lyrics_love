import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<MySearchBar> {
  final controller = TextEditingController();
  Timer? _debounce ;

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void getQuery(String str){
     if(_debounce?.isActive??false){
       _debounce!.cancel();
     }
     _debounce = Timer(Duration(milliseconds: 500),(){


     });

    print(str);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color:Colors.black54),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: getQuery,
        textInputAction: TextInputAction.search,
        decoration:InputDecoration(prefixIcon: Icon(Icons.search),border:InputBorder.none,
        hintText: "search"),

      ),
    );
  }
}
