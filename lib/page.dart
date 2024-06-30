import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController _controller = TextEditingController();

  final List<String> _dificultades = ["Fácil", "Medio", "Avanzado", "Extremo"];
  double _dificultadActual = 1;

  final List<int> _intentos = [5, 8, 15, 25];
  int _intentoActual = 5;

  final List<int> _rangos = [10, 20, 100, 1000];
  int _rangoActual = 10;

  int randomNumber = Random().nextInt(10) + 1;

  final List<String> _menorQue = [];
  final List<String> _mayorQue = [];
  final List<Object> _historial = [];

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Adivina el número",
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
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
                    focusNode: _focusNode,
                    controller: _controller,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelText: "Ingrese un número: ",
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Set focused border color
                      ),
                      hintText: "1 - $_rangoActual ",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSubmitted: (String val) {
                      setState(() {
                        if (!(int.parse(val) < 1) ||
                            !(int.parse(val) > _rangoActual)) {
                          _intentoActual--;

                          if (int.parse(val) != randomNumber) {
                            if (int.parse(val) > randomNumber) {
                              _menorQue.add(val);
                            } else if (int.parse(val) < randomNumber) {
                              _mayorQue.add(val);
                            }
                          } else {
                            _historial.add(Object(value: val, result: true));
                            _menorQue.clear();
                            _mayorQue.clear();
                            _intentoActual =
                                _intentos[_dificultadActual.toInt() - 1];
                            randomNumber = Random().nextInt(10) + 1;
                          }

                          if (_intentoActual < 1) {
                            _historial.add(Object(value: val, result: false));
                            _menorQue.clear();
                            _mayorQue.clear();
                            _intentoActual =
                                _intentos[_dificultadActual.toInt() - 1];
                            randomNumber = Random().nextInt(10) + 1;
                          }
                        }
                        _focusNode.requestFocus();
                      });
                      _controller.clear();
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Intentos(_intentoActual),
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
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  Text(
                    _dificultades[_dificultadActual.toInt() - 1],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Slider(
                    value: _dificultadActual,
                    min: 1,
                    max: 4,
                    divisions: 3,
                    activeColor: Colors.blue[400],
                    inactiveColor: const Color.fromARGB(122, 25, 118, 210),
                    onChanged: (double value) {
                      setState(() {
                        _dificultadActual = value;
                        _menorQue.clear();
                        _mayorQue.clear();
                        _intentoActual =
                            _intentos[_dificultadActual.toInt() - 1];
                        _rangoActual = _rangos[_dificultadActual.toInt() - 1];
                        randomNumber = Random().nextInt(_rangoActual) + 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
