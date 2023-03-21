import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/listaprodutos.dart';






class ListaProdutos_Repository extends ChangeNotifier {

  Future<List<ListaProdutos>> fetch(String categoria) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _ip= prefs.getString('host')!;
    String _porta= prefs.getString('port')!;


    final url = 'http://$_ip:$_porta/getprodutos/$categoria';


    var resposta = await http.get((Uri.parse(url)));


    final lista = List<dynamic>.from(jsonDecode(resposta.body));

    List<ListaProdutos> tudo = [];
    for (var json in lista) {
      final todo = ListaProdutos.fromJson(json);
      tudo.add(todo);
    }

    return tudo;
  }
  @override
  notifyListeners();
}