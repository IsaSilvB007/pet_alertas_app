import 'package:flutter/material.dart';

class RedefinirSenhaView extends StatefulWidget {
  const RedefinirSenhaView({super.key});

  @override
  State<RedefinirSenhaView> createState() => _RedefinirSenhaViewState();
}

class _RedefinirSenhaViewState extends State<RedefinirSenhaView> {
  bool _esconderNovaSenha = true;
  bool _esconderConfirmarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'REDEFINIR SENHA',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                ),
              ),

              SizedBox(height: 75),

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

              SizedBox(height: 30),

              Text(
                'Nova Senha',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              TextField(
                obscureText: _esconderNovaSenha,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _esconderNovaSenha = !_esconderNovaSenha;
                      });
                    },
                    icon: Icon(
                      _esconderNovaSenha
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Text(
                'Confirmar Senha',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              TextField(
                obscureText: _esconderConfirmarSenha,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _esconderConfirmarSenha = !_esconderConfirmarSenha;
                      });
                    },
                    icon: Icon(
                      _esconderConfirmarSenha
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 45),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B83AE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text(
                      'SALVAR SENHA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: Text(
                    'Voltar ao Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4B83AE),
                      fontWeight: FontWeight.w500,
                    ),
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
