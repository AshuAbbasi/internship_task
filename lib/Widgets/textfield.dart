
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  SimpleTextField({
    super.key,  required this.textEditingController, this.passwordhide, this.lefticon, this.hint, this.type,
  });
  final String? hint;
 // final String txt;
  final  IconButton? passwordhide;
  final Icon? lefticon;
 final TextInputType? type;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:textEditingController ,
      keyboardType: type,
      style: TextStyle(
        color: Colors.white.withOpacity(0.4)
      ),
      decoration: InputDecoration(
        fillColor: Colors.white10,
         // labelText: txt,
          hintText: hint,

          labelStyle: TextStyle(color:Colors.black),
          suffixIcon: passwordhide,
          prefixIcon: lefticon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Colors.white10),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Colors.white10),
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
  }
}
class PasswordTextField extends StatefulWidget {
PasswordTextField({
    super.key, required this.txt, required this.textEditingController, this.passwordhide,  this.icons,
  });
  final String txt;
  final  IconButton? passwordhide;
  final Icon? icons;
  final TextEditingController textEditingController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool ispass=false;

  @override

  Widget build(BuildContext context) {

    return TextField(
      style: TextStyle(
          color: Colors.white.withOpacity(0.4)
      ),
      keyboardType: TextInputType.visiblePassword,
      controller:widget.textEditingController ,
      obscureText: ispass,
      decoration: InputDecoration(
          hintText: widget.txt,
          prefixIcon: widget.icons,
          labelStyle: TextStyle(color:Colors.black),
          suffixIcon:  IconButton(
    icon: Icon(ispass
    ? Icons.visibility
        : Icons.visibility_off_sharp),
    onPressed: () {
    setState(() {
    ispass = !ispass;
    });
    },),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Colors.white.withOpacity(0.1),),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Colors.white.withOpacity(0.1),),
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
  }
}

