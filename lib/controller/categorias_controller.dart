
import 'package:flutter/material.dart';

import '../classes/categorias.dart';
import '../classes/listaprodutos.dart';
import '../repository/categorias_repository.dart';
import '../repository/listaprodutos_repository.dart';






class Categorias_Controller {
  List<Categorias> lista=[];

  final repository = Categorias_Repository();

  final state = ValueNotifier<CategoriasState>(CategoriasState.start);



  Future start() async {
    state.value = CategoriasState.loading;
    try {

      lista = await repository.fetch();

    }catch (e) {
      state.value = CategoriasState.error;
    }
    state.value = CategoriasState.sucess;
  }

}
enum CategoriasState{start, loading, sucess,error}