import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Icon icon;
  final String hintText;
  const TextInput({ Key? key,required this.hintText,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white24
        ),
        prefixIcon: icon,
        enabledBorder: const UnderlineInputBorder(      
          borderSide: BorderSide(color: Colors.white),   
        ),  
      ),
      
    );
  }
}