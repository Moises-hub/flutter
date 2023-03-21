import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../classes/lancamento_produto.dart';
import '../controller/produto_controller.dart';
import 'dadositem.dart';

class NewProduto extends StatefulWidget {
  final List<ListaLancamento> lista;

  const NewProduto({Key? key, required this.lista}) : super(key: key);

  @override
  State<NewProduto> createState() => _NewProdutoState();
}

class _NewProdutoState extends State<NewProduto> {
  final _form = GlobalKey<FormState>();
  var _myController = TextEditingController();
  String codbarra = "";
  final controller = Produto_Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _buscar();
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _myController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
      body: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              controller: _myController,
              maxLength: 40,
              autofocus: true,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'DIGITE O CÓDIGO DO PRODUTO';
                }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    scanBarcodeNormal();
                  },
                  icon: const Icon(CupertinoIcons.barcode),
                ),
                labelText: 'CÓDIGO DO PRODUTO',
              ),
              onChanged: (val) {
                setState(() {
                  codbarra = val;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      if (barcodeScanRes != '') {
        _myController.text = barcodeScanRes;
        codbarra = barcodeScanRes;

        barcodeScanRes = '';
      }
    });
  }

  _buscar() async {
    await controller.start(codbarra);
    if (controller.lista.length != 0) {
      Navigator.of(context).pop();
      _dadoItem();

    } else {
      _prodNaoEncontrado();
    }
  }

  _dadoItem() {
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
                lista: widget.lista,
                qnt: '1',
                obs: '',
                id_produto: controller.lista[0].idProduto.toString(),
                descricao: controller.lista[0].descricao.toString(),
                codigoBarras: controller.lista[0].codigoBarras.toString(),
                classificacao: controller.lista[0].classificacao.toString(),
                unidade: controller.lista[0].unidade.toString(),
                type: 0,
                impressora:  controller.lista[0].impressora.toString()
              ),
            ),
          );

        });

  }

  _prodNaoEncontrado() {
    Widget OKButton = ElevatedButton(
        child: Text("Ok"), onPressed: () => Navigator.of(context).pop());
    _myController.clear();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text('PRODUTO NÃO ENCONTRADO!'),
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
