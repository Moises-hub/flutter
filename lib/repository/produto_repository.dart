import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/produto.dart';



class Produto_Repository extends ChangeNotifier {

  Future<List<Produto>> fetch(String codbarra) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _ip= prefs.getString('host')!;
    String _porta= prefs.getString('port')!;


    final url = 'http://$_ip:$_porta/lanca_produto/$codbarra';


    var resposta = await http.get((Uri.parse(url)));


    final lista = List<dynamic>.from(jsonDecode(resposta.body));

    List<Produto> tudo = [];
    for (var json in lista) {
      final todo = Produto.fromJson(json);
      tudo.add(todo);
    }

    return tudo;
  }
  @override
  notifyListeners();
}