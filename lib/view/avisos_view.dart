import 'package:flutter/material.dart';

class AvisosView extends StatefulWidget {
  const AvisosView({super.key});

  @override
  State<AvisosView> createState() => _AvisosViewState();
}

class _AvisosViewState extends State<AvisosView> {
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
