import 'package:flutter/material.dart';

class CustomCardBirthday extends StatelessWidget {
  final DateTime date;
  final String pacienteName;

  String formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${DateTime.now().year}';
  }

  String dateCustomize(DateTime dt) {
    if (formatDate(dt) == formatDate(DateTime.now())) {
      return 'Hoje';
    } else if (formatDate(dt) ==
        formatDate(DateTime.now().add(Duration(days: 1)))) {
      return 'Amanhã';
    } else if (formatDate(dt) ==
        formatDate(DateTime.now().add(Duration(days: 2)))) {
      return 'Depois amanhã';
    }
    return formatDate(dt);
  }

  const CustomCardBirthday(
      {Key? key, required this.date, required this.pacienteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFCB6CE6), width: 2)),
      child: IntrinsicWidth(
        child: Column(
          children: [
            Text(dateCustomize(date),
                style: TextStyle(color: Colors.white, fontSize: 18)),
            Text(
              pacienteName,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.cake_rounded,
                color: Colors.amber[100],
              ),
            )
          ],
        ),
      ),
    );
  }
}
