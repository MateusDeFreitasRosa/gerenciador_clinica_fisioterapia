import 'package:fisio_studio/models/pages.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final dynamic changePage;
  const CustomTabBar({Key? key, required this.changePage}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  List<CustomButtonTabBar> buttonsBars = [];

  buildCustomBUttonTabBar() {
    pages.forEach((key, value) {
      buttonsBars.add(CustomButtonTabBar(
        icon: value['icon'],
        label: value['name'],
        changePage: widget.changePage,
        idPage: key,
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    buildCustomBUttonTabBar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      width: 300,
      child: Column(
        children: buttonsBars,
      ),
    );
  }
}

class CustomButtonTabBar extends StatelessWidget {
  final String label;
  final Icon icon;
  final dynamic changePage;
  final int idPage;

  const CustomButtonTabBar(
      {Key? key,
      required this.icon,
      required this.label,
      required this.changePage,
      required this.idPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changePage(idPage);
      },
      child: Container(
        color: Colors.grey.shade800,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
