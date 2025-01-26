import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttonlogin extends StatelessWidget {
  final VoidCallback onTab;
  final String text;
  final double? tsize;
  final Color? txtc;
  final Color color;
  final Color bcolor;
  final double?  width;
  final double?  height;
  final BorderRadiusGeometry? borderRadius;

   Buttonlogin({super.key, required this.onTab,
     required this.text, required this.color, this.txtc=Colors.pink,
     this.bcolor=Colors.white, this.width=200, this.height=50, this.tsize=17, this.borderRadius,});

  @override
  Widget build(BuildContext context) {

    return TextButton(
      //splashColor: Colors.yellow,
      onPressed: onTab,
        child:
      Container(
        height:height,
        width: width,
        decoration: BoxDecoration(
gradient: LinearGradient(colors: [
  Colors.purpleAccent,
  Colors.deepOrangeAccent
]),
            borderRadius: borderRadius,


              color: color
        ),
        child: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: tsize,color: txtc),),),
    ),
    );
  }
}
