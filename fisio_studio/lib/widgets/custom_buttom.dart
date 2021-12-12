import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final dynamic onPressed;
  const CustomButtom({ Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFCB6CE6)
        ),
        child: Container(
          alignment: Alignment.center,
            child: const Text(
            'Acessar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        )
      )
    );
  }
}