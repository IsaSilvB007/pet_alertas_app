import 'package:flutter/material.dart';

class EmitirAlertaView extends StatefulWidget {
  const EmitirAlertaView({super.key});

  @override
  State<EmitirAlertaView> createState() => _EmitirAlertaViewState();
}

class _EmitirAlertaViewState extends State<EmitirAlertaView> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: []),
        ),
      ),
    );
  }
}
