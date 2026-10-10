import 'package:flutter/material.dart';

class SobreOngsView extends StatefulWidget {
  const SobreOngsView({super.key});

  @override
  State<SobreOngsView> createState() => _SobreOngsViewState();
}

class _SobreOngsViewState extends State<SobreOngsView> {
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
