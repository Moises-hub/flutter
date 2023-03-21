import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Configuracao extends StatefulWidget {

  @override
  _ConfiguracaoState createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {

  String ip ='';
  String port ='';





  var ipController = TextEditingController();
  var portController = TextEditingController();
  final _formKey = GlobalKey<FormState>();





  @override
  void initState() {
    _getConfig();

    super.initState();

  }




  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Text('Configuração', style: TextStyle(fontSize: 25, color: Colors.white),),
          centerTitle: true,
        ),
        body:

        Container(
            padding: const EdgeInsets.only(top: 0, left: 50, right: 50),
            color: CupertinoColors.darkBackgroundGray,
            child:
            Form(
                key: _formKey,
                child:
                ListView(
                    children: [
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/coliseu_1.png',height: 50,width: 50,)),

                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        height: 40,
                        child: Center(
                          child:

                          TextFormField(

                            controller: ipController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Digite o Host';
                              }
                              return null;
                            },
                            onChanged: (val) =>

                                initiateIp(val),
                            decoration: InputDecoration(
                              labelText: 'Digite Host ou IP e Acesso ex. localhost / 192.0.0.100',
                              labelStyle: const TextStyle(color: Colors.blueGrey, fontSize: 15),
                              errorStyle: const TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                            ),

                            keyboardType: TextInputType.text,


                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),




                      SizedBox(
                        height: 40,
                        child: Center(
                          child:

                          TextFormField(
                            controller: portController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Digite a Porta';
                              }
                              return null;
                            },
                            onChanged: (val) =>

                                initiatePort(val),
                            decoration: InputDecoration(
                              labelText: 'Digite a Porta de Acesso ex. 8181',
                              labelStyle: const TextStyle(color: Colors.blueGrey, fontSize: 15),
                              errorStyle: const TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                            ),



                            keyboardType: TextInputType.number,


                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,),
                      Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child:
                            ElevatedButton(

                              onPressed: () {
                                if (_formKey.currentState!.validate()) {

                                  addStringToSF(ip, port);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data'))

                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Colors.blueGrey),
                              child: const Text(
                                'Salvar',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),

                          )
                      ),
                    ]
                )
            )
        ));

  }

  _saveConfig() async{
    //  var document = await FirebaseFirestore.instance.collection('servidores').where('empresa',isEqualTo: reponse.toString()).post();
  }





  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Text("ALterações salvo com Sucesso!"),
      actions: [
        ElevatedButton(

            child: Text("Ok",style: TextStyle(color: Colors.white),),
            onPressed: () {

              Navigator.of(context).pop();
              setState((){
                Navigator.of(context).pop();
              });
            }
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  void initiateIp(String val) {
    setState(() {
      ip = val;

    });
  }

  void initiatePort(String val) {
    setState(() {
      port = val;

    });
  }



  addStringToSF(String _ip,_port) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    prefs.setString('host', _ip);
    if (_port == null)
      prefs.setString('port', '8181');
    else
      prefs.setString('port', _port);


    setState(() {
      showAlertDialog(context);


    }

    );
  }

  _getConfig()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      ip = prefs.getString('host')!;
      port = prefs.getString('port')!;
      ipController = new TextEditingController(text: ip);
      portController = new TextEditingController(text: port);
    });
  }
}


