import 'package:flutter/material.dart';


class Head extends StatelessWidget {
  final String label;

  const Head({ Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            color: Colors.black26,
            child: Text(
              this.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),
            ),
          ) 
        )
      ],
    );
  }
}