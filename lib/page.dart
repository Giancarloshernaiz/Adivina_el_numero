import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'components/dificultad.dart';
import 'components/historial.dart';
import 'components/intentos.dart';
import 'components/menor_que.dart';
import 'components/mayor_que.dart';

class Object {
  final String value;
  final bool result;

  Object({required this.value, required this.result});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int randomNumber = Random().nextInt(10) + 1;

  final TextEditingController _controller = TextEditingController();

  final int _intentos = 5;

  final List<String> _menorQue = [];
  final List<String> _mayorQue = [];
  final List<Object> _historial = [];

  final List<String> _dificultades = ['Fácil', 'Medio', 'Avanzado', 'Extremo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Adivina el número",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            Icon(Icons.menu, color: Colors.white, size: 30.0),
          ],
        )),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      labelText: "Ingrese un número: ",
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Set focused border color
                      ),
                      hintText: "####",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (String val) {
                      print(randomNumber);
                      _controller.clear();
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Intentos(_intentos),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MenorQue(_menorQue),
                MayorQue(_mayorQue),
                Historial(_historial),
              ],
            ),
            Dificultad(_dificultades),
          ],
        ),
      ),
    );
  }
}
