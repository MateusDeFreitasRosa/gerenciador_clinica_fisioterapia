import 'package:fisio_studio/controllers/addCredits.dart';
import 'package:fisio_studio/controllers/getCredits.dart';
import 'package:fisio_studio/controllers/sharedPreference.dart';
import 'package:fisio_studio/widgets/card_credits.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:fisio_studio/components.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BuyCredits extends StatefulWidget {
  const BuyCredits({Key? key}) : super(key: key);

  @override
  State<BuyCredits> createState() => _BuyCreditsState();
}

class _BuyCreditsState extends State<BuyCredits>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CardCredits> cardCredits = [];
  List<CardMyCredits> cardMyCredits = [];
  List<CardBuy> cardBuy = [];
  TextEditingController ammoutController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');
  Map<String, dynamic> credits = {};
  double priceTotal = 0;
  int ammoutTotal = 0;
  String cpf = '';
  int auxID = 0;
  bool freezeScreen = false;

  bool cpfIsCheck = false;

  void forceSetState() {
    setState(() {
      calcTotalPrice();
      calcTotalAmmout();
    });
  }

  void delete(String key) {
    print('Delete');
    credits.remove(key);

    cardBuy = [];
    setState(() {
      credits.forEach((key, value) {
        cardBuy.add(
          CardBuy(
            ammoutController: value['controllerAmmout'],
            priceController: value['controllerPrice'],
            forceSetState: forceSetState,
            delete: delete,
            title: key,
          ),
        );
      });
    });
    forceSetState();
  }

  void addCreditToCart(String key) {
    try {
      setState(() {
        if (credits.containsKey(key)) {
          credits[key]['controllerAmmout'].text =
              (int.parse(credits[key]['controllerAmmout'].text) + 1).toString();
        } else {
          credits.addAll({
            key: {
              //'ammout': 1,
              //'price': 0.0,
              'controllerAmmout': TextEditingController(text: '1'),
              'controllerPrice': MoneyMaskedTextController(
                  decimalSeparator: ',',
                  thousandSeparator: '.',
                  leftSymbol: 'R\$'),
            }
          });
          cardBuy.add(
            CardBuy(
              ammoutController: credits[key]['controllerAmmout'],
              priceController: credits[key]['controllerPrice'],
              forceSetState: forceSetState,
              delete: delete,
              title: key,
            ),
          );
        }
      });
      forceSetState();
    } catch (e) {
      print(e);
    }

    print('lenCard: ${cardBuy.length}');
  }

  void calcTotalPrice() {
    priceTotal = 0;
    ammoutTotal = 0;
    credits.forEach((key, value) {
      print('Antes: ${value['controllerPrice'].text}');
      double price = value['controllerPrice'].text != ''
          ? double.parse((value['controllerPrice'].text)
              .toString()
              .substring(2)
              .replaceAll('.', '')
              .replaceAll(',', '.'))
          : 0;
      print('Depois: $price');
      int ammout = value['controllerAmmout'].text != ''
          ? int.parse(value['controllerAmmout'].text)
          : 0;
      priceTotal += price * ammout;
      ammoutTotal += ammout;
    });
  }

  void calcTotalAmmout() {
    credits.forEach((key, value) {});
  }

  buildCreditsToBuy() async {
    dynamic cards = await loadSharedPreference('services');
    cardCredits = [];
    if (cards.length > 0) {
      for (var card in cards) {
        setState(() {
          cardCredits.add(CardCredits(
            label: card,
            func: addCreditToCart,
            addNewCredits: buildCreditsToBuy,
          ));
        });
      }
    } else {
      setState(() {
        cardCredits;
      });
    }

    print('++++++++++++++++++++++++++++++++++++++++++++++++++');
    print(cards);
    //setState(() => cardCredits);
  }

  List<Widget> buildAlertNewCredits(List<Map<String, dynamic>> list) {
    List<Widget> listaWidget = [];

    list.forEach((element) {
      listaWidget.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.black,
              ),
              Text(
                element['tipo'].toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Text(
            element['quantidade'].toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.green),
            padding: const EdgeInsets.all(2),
            child: const Icon(
              Icons.check,
              color: Colors.black,
              size: 17,
            ),
          )
        ],
      ));
    });
    return listaWidget;
  }

  void alertNewCredits(List<Widget> elements) {
    Alert(
        context: context,
        title: 'Créditos adicionados.',
        content: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Beneficiado: $cpf',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Column(children: elements)
            ],
          ),
        ),
        style: const AlertStyle(isCloseButton: false),
        buttons: [
          DialogButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.check,
              color: Colors.green,
              size: 25,
            ),
          )
        ]).show();
  }

  buyNewCredits() async {
    try {
      setState(() {
        freezeScreen = true;
      });
      List<Map<String, dynamic>> mapResults = [];

      for (var key in credits.keys) {
        dynamic response = await addCredits(
            pacienteCPF: cpf,
            quantidade: credits[key]['controllerAmmout'].text,
            valorUnidade: double.parse((credits[key]['controllerPrice'].text)
                .toString()
                .substring(2)
                .replaceAll('.', '')
                .replaceAll(',', '.')),
            tipo: key);

        mapResults.add(
            {'tipo': response['tipo'], 'quantidade': response['quantidade']});
      }

      List<Widget> elements = buildAlertNewCredits(mapResults);
      alertNewCredits(elements);
      await buildMyCredits();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        freezeScreen = false;
      });
    }
  }

  Future<void> buildMyCredits() async {
    try {
      // setState(() {
      //   freezeScreen = true;
      // });

      print('CHEGO AQUI?????');
      dynamic results = await getCredits(pacienteCPF: cpf);

      Map<String, dynamic> map = {};
      await results.forEach((element) {
        if (map.containsKey(element['tipo'])) {
          List<Map<String, dynamic>> lista = map[element['tipo']]['list'];
          lista.add({
            'quantidade': element['quantidade'],
            'validade': element['validade'],
          });
          map[element['tipo']]['list'] = lista;
        } else {
          map.addAll({
            element['tipo']: {
              'list': [
                {
                  'quantidade': element['quantidade'],
                  'validade': element['validade'],
                }
              ]
            }
          });
        }
      });
      cardMyCredits = [];
      map.forEach((key, value) {
        print('Instancia: $key');
        print('Value: ${value['list']}');
        setState(() {
          cardMyCredits.add(CardMyCredits(label: key, list: value['list']));
        });
      });
    } catch (e) {
      print(e);
    } finally {
      // setState(() {
      //   freezeScreen = false;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    buildCreditsToBuy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: freezeScreen,
        child: Container(
          decoration: backgroundApp,
          child: Row(
            children: [
              //1º coluna.
              Expanded(
                flex: 65,
                child: Column(
                  children: [
                    Expanded(
                        child: Row(
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
                              onChanged: (value) {
                                cpf = value;
                              },
                              enableWrite: !cpfIsCheck,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() => cpfIsCheck = !cpfIsCheck);
                              if (cpfIsCheck) {
                                buildMyCredits();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: cpfIsCheck
                                      ? Colors.red.shade400
                                      : Colors.blue.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                cpfIsCheck ? Icons.close : Icons.check,
                                color: Colors.white,
                                size: 25,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                credits = {};
                                cardBuy = [];
                              });
                              forceSetState();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 25,
                              ),
                            ))
                      ],
                    )),
                    Expanded(
                        flex: 8,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: cardBuy.length,
                                        itemBuilder: (context, index) {
                                          return cardBuy[index];
                                        })),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
                                  padding: const EdgeInsets.all(5),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: const Text(
                                              'Quantidade',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                5))),
                                            child: Text(
                                              ammoutTotal.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: const Text(
                                              'Preço Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                5))),
                                            child: Text(
                                              'R\$${(priceTotal).toStringAsFixed(2).replaceAll('.', ',')}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      CustomButtom(
                                          onPressed: () {
                                            buyNewCredits();
                                          },
                                          label: 'Adicionar créditos')
                                    ],
                                  ),
                                )
                              ],
                            ))),
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
                                Column(
                                  children: [
                                    AddNewCredits(
                                      addNewCredits: buildCreditsToBuy,
                                    ),
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
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount: cardCredits.length,
                                              itemBuilder: (context, index) {
                                                return cardCredits[index];
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                                cardMyCredits.isEmpty
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
                                    : ListView.builder(
                                        itemCount: cardMyCredits.length,
                                        itemBuilder: (context, index) {
                                          return cardMyCredits[index];
                                        },
                                      )
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewCredits extends StatelessWidget {
  final addNewCredits;

  AddNewCredits({Key? key, required this.addNewCredits}) : super(key: key);

  String texto = '';
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
            border: Border.all(color: Colors.black)),
        //padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              child: const Text(
                'Cadastrar novo serviço',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                Alert(
                    context: context,
                    style: const AlertStyle(
                        backgroundColor: Colors.white,
                        titleStyle: TextStyle(color: Colors.black),
                        isCloseButton: false),
                    title: 'Cadastrar novo serviço',
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Ex: Pilates',
                        hintStyle: TextStyle(color: Colors.black45),
                        prefixIcon: Icon(
                          Icons.design_services_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        texto = value;
                      },
                    ),
                    buttons: [
                      DialogButton(
                          onPressed: () async {
                            if (!clicked) {
                              clicked = true;
                              String key = 'services';
                              List<String> listaServices = [];
                              if (await containsKeySharedPreferene(key)) {
                                dynamic list = await loadSharedPreference(key);

                                list.forEach((element) {
                                  listaServices.add(element);
                                });
                              }
                              if (!listaServices.contains(texto)) {
                                listaServices.add(texto);
                              }

                              saveSharedPreference(key, listaServices);
                              addNewCredits();
                              Navigator.pop(context);
                            }
                          },
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 35,
                          )),
                      DialogButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 35,
                          ))
                    ]).show();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                    border: Border.all(color: Colors.black38)),
                child: const Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ));
  }
}

class CardBuy extends StatelessWidget {
  final TextEditingController ammoutController;
  final TextEditingController priceController;
  final title;
  final forceSetState;
  final delete;

  const CardBuy(
      {Key? key,
      required this.ammoutController,
      required this.priceController,
      required this.forceSetState,
      required this.delete,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 20,
            child: Row(
              children: [
                Container(
                  child: const Icon(
                    Icons.add,
                    size: 25,
                  ),
                  margin: const EdgeInsets.only(right: 10),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          ammoutController.text =
                              (int.parse(ammoutController.text) + 1).toString();
                          forceSetState();
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 22,
                        )),
                    SizedBox(
                        width: 45,
                        height: 45,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: ammoutController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: '1',
                              border: InputBorder.none,
                            ),
                            onChanged: (String? value) {
                              forceSetState();
                            },
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          if (int.parse(ammoutController.text) > 1) {
                            ammoutController.text =
                                (int.parse(ammoutController.text) - 1)
                                    .toString();
                            forceSetState();
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
          ),
          Expanded(
            flex: 30,
            child: Column(
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
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: priceController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Ex: R\$250,00',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          forceSetState();
                        },
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
            ),
          ),
          TextButton(
              onPressed: () {
                delete(title);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
    );
  }
}
