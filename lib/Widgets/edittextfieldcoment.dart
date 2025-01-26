
import 'package:flutter/material.dart';

class editTextField extends StatelessWidget {
  editTextField({
    super.key, required this.text, this.maxlines, this.maxlength, this.textInputType,
    this.controller,this.iconButton,  this.isExpand=false, this.avatarpic, this.onsubmited, this.onchanges,
  });
 final VoidCallback? onsubmited;
  final VoidCallback? onchanges;
  final String text;
  final bool isExpand;
  final controller;
  final int? maxlines;
  final int? maxlength;
  final IconButton? iconButton;
  final TextInputType? textInputType;
  final Container? avatarpic;
  @override
  Widget build(BuildContext context) {
    return TextField(

      keyboardType: textInputType,
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxlines,
      maxLength: maxlength,
      controller: controller,
      expands: isExpand,
      decoration: InputDecoration(
        // isCollapsed: isExpand,
          prefixIcon:avatarpic ,
          suffixIcon: iconButton,
          hintText: text,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black54,width: 1)
          ),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black54,width: 1)
          )
      ),
    );
  }
}
