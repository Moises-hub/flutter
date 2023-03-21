
import 'package:flutter/material.dart';

import '../classes/pedidoitens.dart';
import '../repository/pedidoitens_repository.dart';

class PedidoItens_Controller {
  List<PedidosItens> lista=[];

  final repository = PedidosItens_Repository();

  final state = ValueNotifier<PedidoItensState>(PedidoItensState.start);



  Future start(String comanda,String lancamento) async {
    state.value = PedidoItensState.loading;
    try {

      lista = await repository.fetch(comanda,lancamento);

    }catch (e) {
      state.value = PedidoItensState.error;
    }
    state.value = PedidoItensState.sucess;
  }

}
enum PedidoItensState{start, loading, sucess,error}