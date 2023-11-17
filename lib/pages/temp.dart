import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class temp extends StatelessWidget {
  const temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Expanded(
            child: Container(
              color: Colors.red,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
          );
        }
      ),
    );
  }
}
