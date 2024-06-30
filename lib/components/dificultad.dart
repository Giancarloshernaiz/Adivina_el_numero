import 'package:flutter/material.dart';

class Dificultad extends StatefulWidget {
  final List<String> _dificultades;
  const Dificultad(this._dificultades, {super.key});

  @override
  State<Dificultad> createState() => _DificultadState();
}

class _DificultadState extends State<Dificultad> {
  double _dificultadActual = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          Text(
            widget._dificultades[_dificultadActual.toInt() - 1],
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
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
              });
            },
          ),
        ],
      ),
    );
  }
}
