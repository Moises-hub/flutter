import 'package:coliseucomanda/componentes/itenpedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/pedidos_controller.dart';
import 'listitens.dart';

class ListaPedidos extends StatefulWidget {
  final String comanda;
  final String cliente;

  const ListaPedidos({Key? key, required this.comanda, required this.cliente})
      : super(key: key);

  @override
  State<ListaPedidos> createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  final controller = Pedidos_Controller();

  _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start(widget.comanda);
        },
        child: const Text('Tentar Novamente'),
      ),
    );
  }

  stateManagement(PedidosState state) {
    switch (state) {
      case PedidosState.start:
        return _start();

      case PedidosState.loading:
        return _loading();

      case PedidosState.sucess:
        return _sucess();

      case PedidosState.error:
        return _error();
      default:
        return _start();
    }
  }

  _sucess() {
    return ListView.builder(
      itemCount: controller.lista.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItensPedido(
                            comanda: widget.comanda,
                            lancamento:
                                controller.lista[index].lancamento.toString(),
                          )));
            },
            leading: SizedBox(
              width: 60,
              //getCor(listaDeBalanco[index].status),
              child: Center(
                child: Row(children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: Colors.red,
                  ),
                  Text(
                    '${controller.lista[index].data.toString()[0]}${controller.lista[index].data.toString()[1]}/${controller.lista[index].data.toString()[3]}${controller.lista[index].data.toString()[4]}',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ]),
              ),
            ),
            title: Text(
              'Lançamento: ${controller.lista[index].lancamento.toString()}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Total: ${formate.format(double.parse(controller.lista[index].total.toString())).toString()}'),
            trailing: const Icon(
              Icons.paste_outlined,
              size: 35,
              color: Colors.blueGrey,
            ),
          ),
        );
      },
    );
  }

  final formate = NumberFormat.currency(locale: 'pt_br', symbol: "R\$");

  @override
  void initState() {
    super.initState();
    controller.start(widget.comanda);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 55,
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Column(children: [
           const Text('Pedidos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text(widget.cliente, style: TextStyle(fontSize: 12)),
            Text(widget.comanda, style: TextStyle(fontSize: 12)),
          ])),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              // hides leading widget

              elevation: 0,
              backgroundColor: Colors.blueGrey,
              toolbarHeight: 35,
              bottom:  const TabBar(
                   /* indicator: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(5.0),
                            right: Radius.circular(5)),
                        // Creates border
                        color: Colors.white),*/
                    indicatorSize: TabBarIndicatorSize.tab,

                    indicatorColor: CupertinoColors.activeOrange,
                    indicatorWeight: 5,

                    labelColor: Colors.black,

                    labelStyle: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                    //For Selected tab
                    unselectedLabelStyle: TextStyle(fontSize: 10.0),
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    tabs: <Widget>[
                      Tab(
                          child: Text(
                        'PEDIDOS',
                        style: TextStyle(color: Colors.black),
                      )),
                      Tab(
                        child: Text('ITENS',
                            style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),

          body: TabBarView(
            children: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: AnimatedBuilder(
                  animation: controller.state,
                  builder: (context, child) {
                    return stateManagement(controller.state.value);
                  },
                ),
              ),

          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:ListItem(comanda: widget.comanda,)
          )
            ],
          ),
        ),
      ),
    );
  }
}
