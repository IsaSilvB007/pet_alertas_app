import 'package:flutter/material.dart';

class GerenciarAlertasView extends StatefulWidget {
  const GerenciarAlertasView({super.key});

  @override
  State<GerenciarAlertasView> createState() => _GerenciarAlertasViewState();
}

class _GerenciarAlertasViewState extends State<GerenciarAlertasView> {
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
