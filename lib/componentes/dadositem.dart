import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/lancamento_produto.dart';

class DadosProduto extends StatefulWidget {
  final  List<ListaLancamento> lista;
  final  String qnt;
  final  String obs;
  final String id_produto;
  final String descricao;
  final String codigoBarras;
  final String classificacao;
  final String unidade;
  final int type;
  final String impressora;


  const DadosProduto({Key? key, required this.lista, required this.qnt, required this.obs, required this.id_produto, required this.descricao, required this.codigoBarras, required this.classificacao, required this.unidade, required this.type, required this.impressora}) : super(key: key);

  @override
  State<DadosProduto> createState() => _DadosProdutoState();
}

class _DadosProdutoState extends State<DadosProduto> {
  final _form = GlobalKey<FormState>();
  var _myController = TextEditingController();
  var _obsController = TextEditingController();


@override
void initState() {
  _myController.text = widget.qnt;
  _obsController.text = widget.obs;
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child:Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(onPressed: (){
          _editar();
        }, child: const Text(
          "Salvar",
          style: TextStyle(color: Colors.white),
        ),),
        const SizedBox(width: 15,),
        ElevatedButton(onPressed: (){
          _myController.clear();
          Navigator.of(context).pop();

        }, child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.white),
        ),),
      ],
    )
        ),


      body:  Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.codigoBarras.toString()} - ${widget.descricao.toString()}',
                  style: const TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),

                ),

                TextFormField(
                  controller: _myController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  maxLength: 2,
                  style: const TextStyle(fontSize: 15,color: Colors.blueAccent),
                  decoration: const InputDecoration(labelText: 'QUANTIDADE'),

                ),
                TextFormField(
                    controller:_obsController,
                  style: const TextStyle(fontSize: 15,color: Colors.blueAccent),
                  decoration: const InputDecoration(labelText: 'OBS'),

                ),
              ],
            ),
          ),
        ),

    );
  }

  _editar() {
    var qnt = int.parse(_myController.text);
    var contem = widget.lista.indexWhere((element) =>
    element.id_produto == widget.id_produto);
    if (contem != -1) {
      if(widget.type == 0) {
        qnt = qnt + int.parse(widget.lista[contem].qnt.toString());
      }
      widget.lista[contem].qnt = qnt.toString();
      widget.lista[contem].obs = _obsController.text;
      Navigator.of(context).pop();
    }
    else {
      widget.lista.add(
          ListaLancamento(
              id_produto: widget.id_produto,
              descricao: widget.descricao,
              codigobarras: widget.codigoBarras.toString(),
              classificacao:widget.classificacao.toString(),
              unidade: widget.unidade.toString(),
              obs: _obsController.text,
              qnt: qnt.toString(),
              impressora:  widget.impressora)

      );

      Navigator.of(context).pop();
    }
  }
}
