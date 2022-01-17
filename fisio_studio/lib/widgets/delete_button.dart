import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Alert(
            context: context,
            title: 'Tem certeza que deseja excluir esse usuário?',
            desc: 'Essa ação não poderá ser desfeita',
            style: AlertStyle(
                isCloseButton: false,
                descStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900),
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            buttons: [
              DialogButton(
                color: Colors.blue.shade900,
                child: const Text(
                  "Tenho certeza!",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {},
              ),
              DialogButton(
                color: Colors.red.shade900,
                child: const Text(
                  "Não tenho certeza!",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]).show();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: const Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
      ),
    );
  }
}
