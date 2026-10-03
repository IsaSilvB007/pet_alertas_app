import 'package:flutter/material.dart';

class BotaoHome extends StatelessWidget {
  final String texto;
  final Color cor;
  final IconData icone;
  final VoidCallback onPressed;

  const BotaoHome({
    super.key,
    required this.texto,
    required this.cor,
    required this.icone,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: cor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: Text(texto),
        iconAlignment: IconAlignment.end,
        icon: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(icone),
        ),
      ),
    );
  }
}
