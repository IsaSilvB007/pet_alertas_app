import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(Icons.login, size: 90),
              SizedBox(height: 30),

              Text('E-MAIL', style: TextStyle(fontSize: 20)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Text('SENHA', style: TextStyle(fontSize: 20)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility_off),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'recuperar_senha');
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
