
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Widgets/small_text.dart';

import '../utilis/app_colors.dart';





class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double? size;

  const ExpandableTextWidget({super.key, required this.text, this.size});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firsthalf;
  late  String secondhalf;

  bool hiddinText=true;
  double textHight=100;

  @override
  void initState() {
    super.initState();

    if(widget.text.length>textHight){
      firsthalf =widget.text.substring(0,textHight.toInt());
      secondhalf=widget.text.substring(textHight.toInt(),widget.text.length);
    }
    else
    {
      firsthalf=widget.text;
      secondhalf="";
    }
      }

  @override
  Widget build(BuildContext context) {
    double size=16;
    return Container(
      child: secondhalf.isEmpty?SmallText(text: firsthalf):Column(
        children: [
          SmallText(size: size,
              text: hiddinText?(firsthalf+"..."):(firsthalf+secondhalf)),
         SizedBox(height: 10,),
          InkWell(
            onTap: (){
              setState(() {
                hiddinText=!hiddinText;
              });
            },

            child: Row(mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SmallText(text: hiddinText?"show more":"show less", color: AppColors.maincolour,size: size,),
            /*  setting arown condition up to ddown */
              Icon(hiddinText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.maincolour,),

    ],
    )

          )
        ],
      ),

    );
  }
}
