import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/newlancamento.dart';


class NewLancamento_Repository extends ChangeNotifier {

  Future<List<NewLancamento>> fetch(String comanda,String type) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _ip= prefs.getString('host')!;
    String _porta= prefs.getString('port')!;


    final url = 'http://$_ip:$_porta/lancar_comanda/$comanda/$type';

    var resposta = await http.get((Uri.parse(url)));


    final lista = List<dynamic>.from(jsonDecode(resposta.body));

    List<NewLancamento> tudo = [];
    for (var json in lista) {
      final todo = NewLancamento.fromJson(json);
      tudo.add(todo);
    }

    return tudo;
  }
  @override
  notifyListeners();
}