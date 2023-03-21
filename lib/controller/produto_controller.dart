
import 'package:flutter/material.dart';

import '../classes/produto.dart';
import '../repository/produto_repository.dart';





class Produto_Controller {
  List<Produto> lista=[];

  final repository = Produto_Repository();

  final state = ValueNotifier<ProdutoState>(ProdutoState.start);



  Future start(String codbarra) async {
    state.value = ProdutoState.loading;
    try {

      lista = await repository.fetch(codbarra);

    }catch (e) {
      state.value = ProdutoState.error;
    }
    state.value = ProdutoState.sucess;
  }

}
enum ProdutoState{start, loading, sucess,error}