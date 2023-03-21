import 'package:coliseucomanda/controller/listaprodutos_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaProdutos_Screen extends StatefulWidget {
  final String idcategoria;
  final String categoria;
  final IconData icone;
  const ListaProdutos_Screen({Key? key, required this.categoria, required this.idcategoria, required this.icone}) : super(key: key);

  @override
  State<ListaProdutos_Screen> createState() => _ListaProdutos_ScreenState();
}

class _ListaProdutos_ScreenState extends State<ListaProdutos_Screen> {
  final controller = ListaProdutos_Controller();

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
          controller.start(widget.idcategoria);
        },
        child: const Text('Tentar Novamente'),
      ),
    );
  }

  stateManagement(ListaProdutosState state) {
    switch (state) {
      case ListaProdutosState.start:
        return _start();

      case ListaProdutosState.loading:
        return _loading();

      case ListaProdutosState.sucess:
        return _sucess();

      case ListaProdutosState.error:
        return _error();
      default:
        return _start();
    }
  }
  final formate = NumberFormat.currency(locale: 'pt_br', symbol: "R\$");
  _sucess() {
    return ListView.builder(
      itemCount: controller.lista.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading:  Icon(
              widget.icone,
              size: 35,
              color: Colors.green,
            ),


            title: Text('${controller.lista[index].codigoBarra.toString()} - ${controller.lista[index].descricao.toString()}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(formate.format(double.parse(controller.lista[index].preco.toString())).toString()),



          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller.start(widget.idcategoria);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CupertinoColors.darkBackgroundGray,
        title: Text(widget.categoria,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}
