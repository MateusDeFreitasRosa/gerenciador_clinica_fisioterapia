import 'package:flutter/material.dart';


class CustomButtomDrawer extends StatelessWidget {

  final String label;
  final dynamic onPressed;
  const CustomButtomDrawer({ Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: ListTile(
        hoverColor: const Color(0x22CB6CE6),
        selectedColor: const Color(0x44CB6CE6),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}