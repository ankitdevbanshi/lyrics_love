import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/pages/lyrics_page.dart';

class MyListTile extends StatelessWidget {
  String title;
  String lyric;
  String imgUrl;
  String hindiLyric;
   MyListTile({required this.hindiLyric,required this.imgUrl,required this.title,required this.lyric,super.key});

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
                // image: DecorationImage(image: Image.network(src)),
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: ClipRRect(borderRadius:BorderRadius.circular(6),child: Image.network(imgUrl,fit: BoxFit.cover,)),
            ),
          SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 200,child: Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
               SizedBox(height: 8,),
                Container(width: 200,child: Text(lyric,maxLines: 1,overflow: TextOverflow.ellipsis,)),
              ],
            ),
          ],),

          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LyricsPage(lyric:lyric,title: title,
                    imgUrl:imgUrl,hindiLyric:hindiLyric)));
              },
              child: Icon(Icons.arrow_forward))
        ],
      ),
    );
  }
}
