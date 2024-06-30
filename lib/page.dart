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
  final List<Object> _historial = [];
  final List<String> _menorQue = [];
  final List<String> _mayorQue = [];
  final List<String> _dificultades = ["Fácil", "Medio", "Avanzado", "Extremo"];
  final List<int> _intentos = [5, 8, 15, 25];
  final List<int> _rangos = [10, 20, 100, 1000];
  final _focusNode = FocusNode();
  double _dificultadActual = 1;
  int _intentoActual = 5;
  int _rangoActual = 10;
  int randomNumber = Random().nextInt(10) + 1;

  void showMessage(String value, color, text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            value,
            style: TextStyle(
                color: text, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void reset(val, result) {
    setState(() {
      _historial.add(Object(value: val, result: result));
      _menorQue.clear();
      _mayorQue.clear();
      _intentoActual = _intentos[_dificultadActual.toInt() - 1];
      randomNumber = Random().nextInt(_rangoActual) + 1;
    });
  }

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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "1 - $_rangoActual ",
                      hintStyle: const TextStyle(color: Colors.grey),
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
                    ),
                    onSubmitted: (String val) {
                      setState(() {
                        if (val.isEmpty) {
                          showMessage(
                            'El campo de texto no puede estar vacío!',
                            Colors.amber[600],
                            Colors.black,
                          );
                        }
                        if (int.parse(val) < 1 ||
                            int.parse(val) > _rangoActual) {
                          showMessage(
                            'El número ingresado está fuera de rango (1 - $_rangoActual)',
                            Colors.amber[600],
                            Colors.black,
                          );
                        } else {
                          _intentoActual--;
                          if (int.parse(val) != randomNumber) {
                            if (int.parse(val) > randomNumber) {
                              _menorQue.add(val);
                            } else if (int.parse(val) < randomNumber) {
                              _mayorQue.add(val);
                            }
                          } else {
                            showMessage(
                              "¡Ganaste!",
                              Colors.green[600],
                              Colors.white,
                            );
                            reset(val, true);
                          }
                          if (_intentoActual < 1) {
                            showMessage(
                              'Perdiste! El número era: $randomNumber',
                              Colors.red[700],
                              Colors.white,
                            );
                            reset(val, false);
                          }
                        }
                        _focusNode.requestFocus();
                      });
                      _controller.clear();
                    },
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
