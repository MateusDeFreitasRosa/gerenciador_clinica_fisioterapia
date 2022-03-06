import 'package:fisio_studio/widgets/card_credits.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:fisio_studio/components.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class BuyCredits extends StatefulWidget {
  const BuyCredits({Key? key}) : super(key: key);

  @override
  State<BuyCredits> createState() => _BuyCreditsState();
}

class _BuyCreditsState extends State<BuyCredits>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CardCredits> cardCredits = [];
  TextEditingController ammoutController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  double priceUnitario = 0;
  int ammout = 1;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    buildCreditsToBuy();
    priceController.updateValue(0);
    ammoutController.text = ammout.toString();
  }

  buildCreditsToBuy() {
    List cards = ['Pilates', 'RPG', 'Massagem'];

    for (var card in cards) {
      cardCredits.add(CardCredits(label: card));
    }

    setState(() => cardCredits);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundApp,
        child: Row(
          children: [
            //1º coluna.
            Expanded(
              flex: 65,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: CustomTextFiled(
                              hintText: 'Informe o CPF do Cliente',
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              onChanged: () {}))),
                  Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: ListView(
                          children: [
                            Expanded(
                                child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: const Icon(
                                          Icons.add,
                                          size: 25,
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                      ),
                                      const Text(
                                        'Pilates',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                ammoutController.text =
                                                    (int.parse(ammoutController
                                                                .text) +
                                                            1)
                                                        .toString();
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 22,
                                              )),
                                          Container(
                                            child: SizedBox(
                                                width: 45,
                                                height: 45,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: TextField(
                                                    controller:
                                                        ammoutController,
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: '1',
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                if (int.parse(
                                                        ammoutController.text) >
                                                    1) {
                                                  ammoutController
                                                      .text = (int.parse(
                                                              ammoutController
                                                                  .text) -
                                                          1)
                                                      .toString();
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 22,
                                              )),
                                        ],
                                      ),
                                      const Center(
                                        child: Text(
                                          'Quantidade',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                          width: 150,
                                          height: 45,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: TextField(
                                              controller: priceController,
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                hintText: 'Ex: R\$250,00',
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {},
                                            ),
                                          )),
                                      const Center(
                                        child: Text(
                                          'Preço unitário',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5),
                            ))
                          ],
                        ),
                      ))
                ],
              ),
            ),

            //2º coluna.
            Expanded(
                flex: 35,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TabBar(
                          unselectedLabelColor: Colors.white60,
                          labelColor: Colors.white,
                          tabs: const [
                            Tab(
                              text: 'Comprar',
                            ),
                            Tab(
                              text: 'Meus créditos',
                            )
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              cardCredits.isEmpty
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      child: const Text(
                                        'Nenhum card cadastrado',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  : ListView(children: cardCredits),
                              cardCredits.isEmpty
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      child: const Text(
                                        'Nenhum card cadastrado',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  : ListView(children: cardCredits),
                            ],
                            controller: _tabController,
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
