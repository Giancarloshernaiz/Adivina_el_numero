import 'package:flutter/material.dart';

class Intentos extends StatefulWidget {
  final int intentos;
  const Intentos(this.intentos, {super.key});

  @override
  State<Intentos> createState() => _IntentosState();
}

class _IntentosState extends State<Intentos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Intentos",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          '${widget.intentos}',
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
