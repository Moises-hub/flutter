import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/lancamento_produto.dart';
import 'componentes/dadositem.dart';
import 'componentes/newproduto.dart';

class Lancamento_Screen extends StatefulWidget {
  final String comanda;
  final String mesa;
  final String cliente;
  final String numero;
  final String id_comanda;
  final String id_cliente;


  const Lancamento_Screen({Key? key, required this.comanda, required this.mesa, required this.cliente, required this.numero, required this.id_comanda, required this.id_cliente}) : super(key: key);

  @override
  State<Lancamento_Screen> createState() => _Lancamento_ScreenState();
}

class _Lancamento_ScreenState extends State<Lancamento_Screen> {
  final List<ListaLancamento> lista =[];




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        elevation: 10,
        splashColor: Colors.blueAccent,
        onPressed: (){
          _produto(context);
        },
        backgroundColor: CupertinoColors.activeBlue,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),


           appBar: AppBar(
             backgroundColor: CupertinoColors.darkBackgroundGray,
             toolbarHeight: 70,
             actions: [
               ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     primary: Colors.green,
                   ),
                   onPressed: (){_enviar();}, child: Text('Enviar'))
             ],
             title: Row(
               mainAxisAlignment: MainAxisAlignment.start,

               children: [
                 Expanded(
                   flex:2,
                   child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:[

                       Text('MESA',style: const TextStyle(color: Colors.yellow,fontSize: 15)),


                       Container(
                         width: MediaQuery.of(context).size.width,
                         height: 45,
                         decoration: BoxDecoration(
                           border: Border.all(
                               color: Colors.grey),
                           borderRadius:
                           const BorderRadius.horizontal(
                               left:
                               Radius.circular(5.0),
                               right:
                               Radius.circular(5)),
                         ),
                         child:Center(child:
                         Text(widget.mesa,style: const TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold))),
                       )],),),
                Expanded(
                 flex:5,
                    child:
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.cliente,style: const TextStyle(color: Colors.white, fontSize: 10,fontWeight: FontWeight.bold)),
                     Text(widget.comanda,style: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold)),

                   ],
                 ),
             ),


               ],
             ),
           ),
      body:
      ListView.builder(
    itemCount: lista.length,
    itemBuilder: (context, index) {
      return Dismissible(
          // direction: DismissDirection.startToEnd,
          key: ObjectKey(lista[index]),
      onDismissed: (startToEnd) =>
      showAlertExclusao(lista[index].id_produto.toString()),
      //  onDismissed: (startToEnd) => showAlertExclusao(listaDeBalanco[index], index),
      background: swipeActionLeft(),
      child: Card(
        child:

        ListTile(
            onTap: ()=> _dadoItem(index),
            trailing:  Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
            ),
            alignment: Alignment.center,
            child:Icon(_iconitem(index), color: Colors.white,size: 35,),
          ),

          title: Text('${lista[index].codigobarras.toString()}-${lista[index].descricao.toString()}',style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
          subtitle: Text(_obs(index),style: const TextStyle(color: Colors.blueGrey, fontSize: 10),),
          leading:  Text('${lista[index].qnt.toString()}X',style: const TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),),





      ),),);
    }
    ));
  }

  showAlertExclusao(String id_produto) {
   
      Widget cancelButton =  ElevatedButton(
          child: Text("Sim"),
          onPressed: () {
            lista.removeWhere((item) => item.id_produto == id_produto);

            Navigator.of(context).pop();
          });

      Widget continueButton = ElevatedButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
           // dismiss dialog
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        content: Text("Deseja Excluir o Registro Selecionado"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }



  Widget swipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: const Icon(Icons.delete, color: Colors.white));

_obs(int index){
    if(lista[index].obs.toString() !=null){
      return lista[index].obs.toString();
    }
    else {
      '';
    }
      
    
}


  _produto(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: Text("CÓDIGO DO PRODUTO"),
              //  backgroundColor: CupertinoColors.darkBackgroundGray,
              content:Container(
                height: 150,
              child:
              NewProduto(lista: lista,)
              )
          );
        });
  }

  _dadoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white,
            content: Container(
              height: 300,
              child: DadosProduto(
                lista: lista,
                qnt: lista[index].qnt.toString(),
                obs: lista[index].obs.toString(),
                id_produto: lista[index].id_produto.toString(),
                descricao: lista[index].descricao.toString(),
                codigoBarras: lista[index].codigobarras.toString(),
                classificacao: lista[index].classificacao.toString(),
                unidade: lista[index].unidade.toString(),
                type: 1,
                impressora: lista[index].impressora.toString(),
              ),
            ),
          );
        });
  }






_iconitem(int i){
    if(lista[i].classificacao=='1'||lista[i].classificacao=='2'||lista[i].classificacao=='5'
       ||lista[i].classificacao=='4'){
      return Icons.fastfood;
    }

    if(lista[i].classificacao=='3'){
      return Icons.local_drink;
    }
    if(lista[i].classificacao=='4'){
      return Icons.icecream;
    }


}

_enviar()async {
  if (lista.isNotEmpty) {
    List<String> listar = [];

    Map<String, String>data = {};

    for (int i = 0; i < lista.length; i++) {
      data.addAll({
        "id_cliente": "${widget.id_cliente}",
        "id_comanda": "${widget.id_comanda}",
        "id_produto": "${lista[i].id_produto.toString()}",
        "comanda": "${widget.comanda}",
        "codbarras": "${lista[i].codigobarras.toString()}",
        "qnt": "${lista[i].qnt.toString()}",
        "id_lancamento": "${widget.numero}",
        "id_impressora": "${lista[i].impressora.toString()}",
        "detalhe": "${lista[i].obs.toString()}",
        "cliente": "${widget.cliente}",
        "mesa": "${widget.mesa}",
        "classificacao": "${lista[i].classificacao.toString()}"
      });

      listar.add(jsonEncode(data));
    }
    String body = listar.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _ip= prefs.getString('host')!;
    String _porta= prefs.getString('port')!;


    final url = 'http://$_ip:$_porta/lancar';
    var response = await http.post(
      (Uri.parse(url)),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (jsonDecode(response.body)[0]['executado'] == 'sucess') {
      Navigator.of(context).pop();
    }

    else {
      _nenviado();
    }
  }
}

  _nenviado() {
    Widget OKButton = ElevatedButton(
        child: const Text("Ok"), onPressed: () => Navigator.of(context).pop());

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text('Ouve um erro ao enviar o pedido!'),
      actions: [
        OKButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
