import 'package:flutter/material.dart';

class MenorQue extends StatefulWidget {
  final List<String> entradas;
  const MenorQue(this.entradas, {super.key});

  @override
  State<MenorQue> createState() => _MenorQueState();
}

class _MenorQueState extends State<MenorQue> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
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
                const Text(
                  'Menor que',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Column(
                  children: widget.entradas
                      .map(
                        (valor) => ListTile(
                          title: Center(
                            child: Text(
                              valor,
                              style: const TextStyle(
                                  color: Colors.white,
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
