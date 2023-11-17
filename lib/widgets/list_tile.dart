import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/pages/lyrics_page.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(

            children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
          SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("sub title",),
              ],
            ),
          ],),

          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LyricsPage()));
              },
              child: Icon(Icons.arrow_forward))
        ],
      ),
    );
  }
}
