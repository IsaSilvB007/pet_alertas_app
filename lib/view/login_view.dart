import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _esconderSenha = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Função para fazer login com o Google (Adaptada para Web e Mobile)
  Future<void> _signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      
      if (userCredential.user != null) {
        // Se o login for bem-sucedido, avança para o mapa
        Navigator.pushReplacementNamed(context, 'home_mapa');
      }
    } catch (e) {
      print('Erro ao fazer login com o Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao entrar com o Google: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Adicionado para evitar overflow em telas menores
          padding: const EdgeInsets.all(20),
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

              const SizedBox(height: 50),

              const Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
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

              const SizedBox(height: 25),

              const Text(
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

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
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

              const SizedBox(height: 30),

              // Botão ACESSAR normal
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B83AE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'home_mapa');
                  }, 
                  child: const Text(
                    'ACESSAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // --- NOVO BOTÃO: Entrar com o Google ---
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Color(0xFF4B83AE), width: 1.5),
                  ),
                  icon: const Icon(Icons.g_mobiledata, size: 30, color: Color(0xFF4B83AE)),
                  label: const Text(
                    'Entrar com o Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4B83AE),
                    ),
                  ),
                  onPressed: _signInWithGoogle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}