import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sensors/sensors.dart';

void main() => runApp(MiApp());
//Primer widget inmutable statelessW
class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(), //Llamar a funcion mutable
    );
  }
}
//statefulW Funcion/Widget Mutable

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  List<StreamSubscription<dynamic>> _streamSubscriptions =
    <StreamSubscription<dynamic>>[];

  Future<String> sendData() async{
      var response = await http.post(
      Uri.https('apiproductorjess.azurewebsites.net', '/api/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "NameDevice":"Acelerometro",
        "EventDate":DateTime.now().toIso8601String(),
        "Event":"Evento Dart y CosmosDB"
      })
    );
    print(response);
    return response.body;
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        sendData();
        print("Desde el acelerometro");
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi App Jessica"),
      ),
      body: Center(
        child: new ElevatedButton(
          onPressed: sendData,
          child: new Text("Enviar datos")
        ),
      ),
    );
  }
}