import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();

}

class _InicioState extends State<Inicio> {

  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  Future<String> sendData(String evento) async{
      var response = await http.post(
      Uri.https('apiproductorjess.azurewebsites.net', '/api/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "NameDevice":"Giroscopio",
        "EventDate":DateTime.now().toIso8601String(),
        "Event": evento
      })
    );
    print(response);
    return response.body;
  }
    @override
  void initState() {
    super.initState();
      gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
      });
      print("Subiendoooo...");
      sendData("x="+ event.x.toString() + ", y=" + event.y.toString() + ", z=" + event.z.toString()) ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giroscopio"),
       ),
       body: Center(
         child: Text("Giroscopio"),
       ),
    );
  }
}