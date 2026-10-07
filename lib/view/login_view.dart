import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  bool _esconderSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo_amparapet_vertical.png',
                  height: 140,
                ),
              ),

              SizedBox(height: 70),

              Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                'Email',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 25),

              Text(
                'Senha',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              TextField(
                obscureText: _esconderSenha,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _esconderSenha = !_esconderSenha;
                      });
                    },
                    icon: Icon(_esconderSenha ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'redefinir_senha');
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
                  ),
                ),
              ),

              SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B83AE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'perfil');
                  }, 
                  child: Text(
                    'ACESSAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
