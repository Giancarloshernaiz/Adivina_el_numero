import 'package:flutter/material.dart';
import 'package:agnostiko_test/page.dart';

class Historial extends StatefulWidget {
  final List<Object> entradas;
  const Historial(this.entradas, {super.key});

  @override
  State<Historial> createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Historial',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                Column(
                  children: widget.entradas
                      .map(
                        (valor) => ListTile(
                          title: Center(
                            child: Text(
                              valor.value,
                              style: TextStyle(
                                  color: valor.result
                                      ? Colors.green[800]
                                      : Colors.red[800],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
