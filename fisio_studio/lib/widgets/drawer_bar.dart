import 'package:flutter/material.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: MediaQuery.of(context).size.width*.10,
      child: ListView(
        children: [
          DrawerElement(
            onpressed: (){
              print('Here');
            }, 
            title: 'Cadastrar funcionário', 
            icon: const Icon(
              Icons.person,
              color: Colors.white70,
            )
          ),
        ],
      ),
    );
  }
}


class DrawerElement extends StatelessWidget {
  final String title;
  final dynamic onpressed;
  final Icon icon;
  const DrawerElement({ Key? key, required this.onpressed, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      leading: icon,

    );
  }
}