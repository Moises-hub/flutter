import 'dart:io';

import 'package:coliseucomanda/componentes/listapedidos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'componentes/listacategorias.dart';
import 'configuracao.dart';
import 'controller/newlancamento_controller.dart';
import 'lancamento_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COLISEU COMANDA',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final controller_lancamento = NewLancamento_Controller();
   String mesa ='0';
   String comanda ='0';
   var _myController = TextEditingController();


   _loading() {
     return const Center(child: CircularProgressIndicator());
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      bottomNavigationBar: BottomAppBar(
          color: CupertinoColors.darkBackgroundGray,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                alignment: Alignment.bottomLeft,
                onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Configuracao()));
                },
              ),
              const Spacer(),
              const Text(
                'Coliseu comanda eletr.: 2.0',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  alignment: Alignment.bottomRight,
                  onPressed: () =>
                    showAlertSair()

                  ),
            ],
          )),
      body:  Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: CupertinoColors.darkBackgroundGray,
        child: ListView(
          children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-20,
                padding: const EdgeInsets.all(10),
                color: CupertinoColors.darkBackgroundGray,
                child:  ListView(children: [
                  Card(
                    shadowColor: Colors.white,
                    elevation: 2,
                    color: Colors.black,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                      ),
                      onPressed: () {_lancar(context);},
                      child: Row(
                        children: [
                          Image.asset('assets/images/lancar.png', height: 80),
                          const Expanded(
                            child: Text(
                              'Lançar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    shadowColor: Colors.white,
                    elevation: 2,
                    color: Colors.black,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                      ),
                      onPressed: () {
                        _buscarpedido();
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/pedidos.png', height: 80),
                          const Expanded(
                            child: Text(
                              'Pedidos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    shadowColor: Colors.white,
                    elevation: 2,
                    color: Colors.black,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                        ListaCategorias()));
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/fastfoodnovo.png',
                              height: 80),
                          const Expanded(
                            child: Text(
                              'Produtos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),

    );
  }




   _lancar(BuildContext context) {
     final _form = GlobalKey<FormState>();
     mesa='0';
     showDialog(
         context: context,
         builder: (BuildContext context) {
           // return object of type Dialog
           return AlertDialog(
               title: const Text("DIGITE AS INFORMAÇÕES"),
               //  backgroundColor: CupertinoColors.darkBackgroundGray,
               content:  Container(

                 height: 170,
                 child: Form(
                   key: _form,
                   child: Column(
                     children: [
                       TextFormField(
                         maxLength: 3,
                         autofocus: true,
                         keyboardType: TextInputType.number,
                         initialValue: mesa,
                         validator: (val) {
                           if (val == null || val.isEmpty) {
                             return 'DIGITE O Nº DA MESA';
                           }
                           return null;
                         },
                         decoration: const InputDecoration(
                           labelText: 'Nº DA MESA',
                         ),
                         onChanged: (val) {
                           setState(() {
                             mesa = val;
                           });
                         },
                       ),
                       TextFormField(
                         controller: _myController,
                         keyboardType: TextInputType.number,
                         style: const TextStyle(fontSize: 15),
                         maxLines: 100,
                         minLines: 1,

                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'DIGITE O NUMERO DA COMANDA';
                           }
                           return null;
                         },
                         //  initialValue: comanda,
                         decoration: InputDecoration(
                           suffixIcon: IconButton(
                             onPressed: () {
                               scanBarcodeNormal();
                             },
                             icon: Icon(CupertinoIcons.barcode),
                           ),
                           labelText: 'COMANDA',
                         ),
                         onChanged: (value) {
                           setState(() {
                             comanda = value;
                           });
                         },
                       ),
                     ],
                   ),
                 ),
               ),
               actions: <Widget>[
                 ElevatedButton(
                 //  color: Colors.blue,
                   child: const Text(
                     "Ok",
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () {
                     if (_form.currentState!.validate()) {

                       controller_lancamento.lista.clear();
                       validalancamento(context);


                     }
                   },
                 ),
                 ElevatedButton(

                   child: const Text(
                     "Cancel",
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () {
                     _myController.clear();
                     Navigator.of(context).pop();
                   },
                 )
               ]);
         });
   }


   validalancamento(BuildContext context) async{
     await controller_lancamento.start(_myController.text,'0');
     if (controller_lancamento.lista.length!=0) {
       Route route = MaterialPageRoute(
           builder: (context) => Lancamento_Screen(
             mesa: mesa,
             comanda: comanda,
             numero: controller_lancamento.lista[0].idLanca.toString(),
             cliente: controller_lancamento.lista[0].nome.toString(),
             id_comanda: controller_lancamento.lista[0].idComanda.toString(),
             id_cliente: controller_lancamento.lista[0].idCliente.toString(),
           ));
       Navigator.push(context, route)
           .then((value) => Navigator.of(context).pop());
       _myController.clear();

     } else {
       _comandanaoencontrada();
     }
   }




   _buscarpedido() {
     final _form = GlobalKey<FormState>();
     mesa='0';
     showDialog(
         context: context,
         builder: (BuildContext context) {
           // return object of type Dialog
           return AlertDialog(
               title: const Text("DIGITE AS INFORMAÇÕES"),
               //  backgroundColor: CupertinoColors.darkBackgroundGray,
               content:  SizedBox(

                 height: 170,
                 child: Form(
                   key: _form,
                   child:

                       TextFormField(
                         controller: _myController,
                         keyboardType: TextInputType.number,
                         style: const TextStyle(fontSize: 15),
                         maxLines: 100,
                         minLines: 1,

                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'DIGITE O NUMERO DA COMANDA';
                           }
                           return null;
                         },
                         //  initialValue: comanda,
                         decoration: InputDecoration(
                           suffixIcon: IconButton(
                             onPressed: () {
                               scanBarcodeNormal();
                             },
                             icon: Icon(CupertinoIcons.barcode),
                           ),
                           labelText: 'COMANDA',
                         ),
                         onChanged: (value) {
                           setState(() {
                             comanda = value;
                           });
                         },
                       ),

                 ),
               ),
               actions: <Widget>[
                 ElevatedButton(
                   //  color: Colors.blue,
                   child: const Text(
                     "Ok",
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () {
                     if (_form.currentState!.validate()) {

                       controller_lancamento.lista.clear();
                       validapedidos();


                     }
                   },
                 ),
                 ElevatedButton(

                   child: const Text(
                     "Cancel",
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () {
                     _myController.clear();
                     Navigator.of(context).pop();
                   },
                 )
               ]);
         });
   }

   validapedidos() async{
    await controller_lancamento.start(_myController.text,'1');
     if (controller_lancamento.lista.length!=0) {
       Route route = MaterialPageRoute(
           builder: (context) => ListaPedidos(
             comanda: comanda,
             cliente: controller_lancamento.lista[0].nome.toString(),
           ));
       Navigator.push(context, route)
           .then((value) => Navigator.of(context).pop());
       _myController.clear();

     } else {
       _comandanaoencontrada();
     }
   }

   _comandanaoencontrada() {
     Widget cancelButton = ElevatedButton(
         child: Text("ok"),
         onPressed: () {
           Navigator.of(context).pop();
         });

     // set up the AlertDialog
     AlertDialog alert = AlertDialog(
       content: Text("Comanda fechada / não encontrada"),
       actions: [
         cancelButton,
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
         comanda = barcodeScanRes;

         barcodeScanRes = '';
       }
     });
   }




   showAlertSair() {

     Widget cancelButton =  ElevatedButton(
         child: Text("Sim"),
         onPressed: () => exit(0),);

     Widget continueButton = ElevatedButton(
       child: Text("Cancelar"),
       onPressed: () {
         Navigator.of(context).pop();
         // dismiss dialog
       },
     );

     // set up the AlertDialog
     AlertDialog alert = AlertDialog(
       content: Text("Deseja Realmente Sair da Aplicação?"),
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

}
