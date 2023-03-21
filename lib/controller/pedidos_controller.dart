
import 'package:flutter/material.dart';

import '../classes/pedidos.dart';
import '../repository/pedidos_repository.dart';






class Pedidos_Controller {
  List<Pedidos> lista=[];

  final repository = Pedidos_Repository();

  final state = ValueNotifier<PedidosState>(PedidosState.start);



  Future start(String comanda) async {
    state.value = PedidosState.loading;
    try {

      lista = await repository.fetch(comanda);

    }catch (e) {
      state.value = PedidosState.error;
    }
    state.value = PedidosState.sucess;
  }

}
enum PedidosState{start, loading, sucess,error}