
import 'package:flutter/material.dart';

import '../classes/newlancamento.dart';
import '../repository/newlancamento_repository.dart';



class NewLancamento_Controller {
  List<NewLancamento> lista=[];

  final repository = NewLancamento_Repository();

  final state = ValueNotifier<NewLancamentoState>(NewLancamentoState.start);



  Future start(String comanda,String tipo) async {
    state.value = NewLancamentoState.loading;
    try {

      lista = await repository.fetch(comanda,tipo);

    }catch (e) {
      state.value = NewLancamentoState.error;
    }
    state.value = NewLancamentoState.sucess;
  }

}
enum NewLancamentoState{start, loading, sucess,error}