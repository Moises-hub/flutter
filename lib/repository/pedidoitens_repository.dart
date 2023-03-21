import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/pedidoitens.dart';






class PedidosItens_Repository extends ChangeNotifier {

  Future<List<PedidosItens>> fetch(String comanda,String lancamento) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _ip= prefs.getString('host')!;
    String _porta= prefs.getString('port')!;


    final url = 'http://$_ip:$_porta/getitens/$comanda/$lancamento';


    var resposta = await http.get((Uri.parse(url)));


    final lista = List<dynamic>.from(jsonDecode(resposta.body));

    List<PedidosItens> tudo = [];
    for (var json in lista) {
      final todo = PedidosItens.fromJson(json);
      tudo.add(todo);
    }

    return tudo;
  }
  @override
  notifyListeners();
}