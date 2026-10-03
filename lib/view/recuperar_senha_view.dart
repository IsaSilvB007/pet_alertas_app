import 'package:flutter/material.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Text('RECUPERAR SENHA', style: TextStyle(fontSize: 27)),
              ),
              SizedBox(height: 30),

              Text('E-MAIL'),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Text('NOVA SENHA'),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nova Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Text('CONFIRMAR SENHA', textAlign: TextAlign.start),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 40),

              TextButton(onPressed: () {
                Navigator.pushNamed(context, 'home_view');
              }, child: Text('SALVAR SENHA'))
            ],
          ),
        ),
      ),
    );
  }
}
