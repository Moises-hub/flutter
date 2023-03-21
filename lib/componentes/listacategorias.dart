import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/categorias_controller.dart';
import 'listaprodutos_screen.dart';

class ListaCategorias extends StatefulWidget {
  const ListaCategorias({Key? key}) : super(key: key);

  @override
  State<ListaCategorias> createState() => _ListaCategoriasState();
}

class _ListaCategoriasState extends State<ListaCategorias> {
  final controller = Categorias_Controller();

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
          controller.start();
        },
        child: const Text('Tentar Novamente'),
      ),
    );
  }

  stateManagement(CategoriasState state) {
    switch (state) {
      case CategoriasState.start:
        return _start();

      case CategoriasState.loading:
        return _loading();

      case CategoriasState.sucess:
        return _sucess();

      case CategoriasState.error:
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
            leading: Icon(
              _iconitem(index),
              size: 35,
              color: Colors.blueGrey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaProdutos_Screen(
                    icone: _iconitem(index),
                    categoria: controller.lista[index].descricao.toString(),
                    idcategoria: controller.lista[index].idCategoria.toString(),
                  ),
                ),
              );
            },
            title: Text(
              controller.lista[index].descricao.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CupertinoColors.darkBackgroundGray,
        title: const Text('Selecione a Categoria',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }

  _iconitem(int i) {
    if (controller.lista[i].classificacao == '1' ||
        controller.lista[i].classificacao == '2' ||
        controller.lista[i].classificacao == '5') {
      return Icons.fastfood;
    }

    if (controller.lista[i].classificacao == '3') {
      return Icons.local_drink;
    }
    if (controller.lista[i].classificacao == '4') {
      return Icons.icecream;
    }
  }
}
