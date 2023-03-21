
import 'package:flutter/material.dart';

import '../classes/listaprodutos.dart';
import '../repository/listaprodutos_repository.dart';






class ListaProdutos_Controller {
  List<ListaProdutos> lista=[];

  final repository = ListaProdutos_Repository();

  final state = ValueNotifier<ListaProdutosState>(ListaProdutosState.start);



  Future start(String categoria) async {
    state.value = ListaProdutosState.loading;
    try {

      lista = await repository.fetch(categoria);

    }catch (e) {
      state.value = ListaProdutosState.error;
    }
    state.value = ListaProdutosState.sucess;
  }

}
enum ListaProdutosState{start, loading, sucess,error}