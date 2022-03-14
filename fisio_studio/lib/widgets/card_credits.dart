import 'package:fisio_studio/controllers/sharedPreference.dart';
import 'package:fisio_studio/views/aquisicao_creditos.dart';
import 'package:flutter/material.dart';

class CardCredits extends StatelessWidget {
  final String label;
  final func;
  final addNewCredits;
  const CardCredits(
      {Key? key,
      required this.label,
      required this.func,
      required this.addNewCredits})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Label: $label');
        func(label);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                print('Excluir');
                List<String> listCards = [];
                dynamic list = await loadSharedPreference('services');

                for (var card in list) {
                  if (card != label) {
                    listCards.add(card);
                  }
                }

                saveSharedPreference('services', listCards);
                addNewCredits();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: const Icon(
                  Icons.delete_outline,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardMyCredits extends StatefulWidget {
  final String label;
  final dynamic list;
  const CardMyCredits({Key? key, required this.label, required this.list})
      : super(key: key);

  @override
  State<CardMyCredits> createState() => _CardMyCreditsState();
}

class _CardMyCreditsState extends State<CardMyCredits>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool expanded = false;
  Icon icon = const Icon(
    Icons.arrow_drop_down_rounded,
    size: 25,
  );
  List<CardMy> myCards = [];

  void buildMyCredits() {
    print('Tá chegando aqui?');
    widget.list.forEach((element) {
      setState(() {
        myCards.add(CardMy(
          ammout: element['quantidade'] != null ? element['quantidade'] : 0,
          date: element['validade'] != null ? element['validade'] : 0,
        ));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Cheguei pelo menos aqui?');
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    buildMyCredits();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (controller.value == 0) {
            controller.forward();
            setState(() {
              icon = const Icon(
                Icons.arrow_drop_up_rounded,
                size: 25,
              );
            });
          } else {
            controller.reverse();
            setState(() {
              icon = const Icon(
                Icons.arrow_drop_down_rounded,
                size: 25,
              );
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: icon,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    widget.label,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              SizeTransition(
                sizeFactor: CurvedAnimation(
                  curve: Curves.fastOutSlowIn,
                  parent: controller,
                ),
                child: Column(children: [
                  const HeadMyCredits(),
                  Column(
                    children: myCards,
                  )
                ]),
              )
            ],
          ),
        ));
  }
}

class HeadMyCredits extends StatelessWidget {
  const HeadMyCredits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 20,
            child: Container(),
          ),
          Expanded(
            flex: 30,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'Quantidade',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                'Valido até',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardMy extends StatelessWidget {
  final int ammout;
  final dynamic date;

  const CardMy({Key? key, required this.ammout, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 20,
          child: Container(
            alignment: Alignment.centerLeft,
            child: const Icon(
              Icons.access_time_rounded,
              size: 25,
            ),
          ),
        ),
        Expanded(
          flex: 30,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              ammout.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        Expanded(
          flex: 50,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              date.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
