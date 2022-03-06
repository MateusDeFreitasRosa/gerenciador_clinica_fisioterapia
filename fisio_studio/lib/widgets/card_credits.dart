import 'package:flutter/material.dart';

class CardCredits extends StatelessWidget {
  final String label;
  const CardCredits({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Container(
              child: const Icon(
                Icons.add,
                size: 25,
              ),
              margin: const EdgeInsets.only(right: 10),
            ),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      ),
    ));
  }
}
