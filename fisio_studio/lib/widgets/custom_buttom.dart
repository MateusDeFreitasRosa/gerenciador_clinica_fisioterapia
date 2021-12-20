import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {

  final dynamic onPressed;
  final String label;
  const CustomButtom({ Key? key,required this.onPressed, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFCB6CE6)
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      )
    );
  }
}