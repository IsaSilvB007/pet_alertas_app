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
  
  // Variável de estado para controlar o perfil selecionado ('cidadao' ou 'ong')
  String _perfilSelecionado = 'cidadao';

  // Função para fazer login com o Google (Adaptada para Web e Mobile)
  Future<void> _signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential = await _auth.signInWithPopup(
        googleProvider,
      );

      if (userCredential.user != null && mounted) {
        // Redireciona com base no perfil escolhido no seletor
        String rotaDestino = _perfilSelecionado == 'ong' ? 'home_ong' : 'home_mapa';
        Navigator.pushReplacementNamed(context, rotaDestino);
      }
    } catch (e) {
      debugPrint('Erro ao fazer login com o Google: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao entrar com o Google: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              // --- SELETOR DE PERFIL (Cidadão vs ONG) ---
              const Text(
                'Entrar como:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF4B83AE)),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Cidadão')),
                      selected: _perfilSelecionado == 'cidadao',
                      selectedColor: const Color(0xFF4B83AE),
                      labelStyle: TextStyle(
                        color: _perfilSelecionado == 'cidadao' ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _perfilSelecionado = 'cidadao';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('ONG / Gestão')),
                      selected: _perfilSelecionado == 'ong',
                      selectedColor: const Color(0xFFFF7043), // Destaque visual em coral para a ONG
                      labelStyle: TextStyle(
                        color: _perfilSelecionado == 'ong' ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _perfilSelecionado = 'ong';
                        });
                      },
                    ),
                  ),
                ],
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
                    icon: Icon(
                      _esconderSenha ? Icons.visibility : Icons.visibility_off,
                    ),
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

              const SizedBox(height: 20),

              // Botão ACESSAR com redirecionamento dinâmico
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _perfilSelecionado == 'ong' ? const Color(0xFFFF7043) : const Color(0xFF4B83AE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Direciona com base na escolha do ChoiceChip
                    String rotaDestino = _perfilSelecionado == 'ong' ? 'home_ong' : 'home_mapa';
                    Navigator.pushReplacementNamed(context, rotaDestino);
                  },
                  child: Text(
                    _perfilSelecionado == 'ong' ? 'ACESSAR PAINEL ONG' : 'ACESSAR',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // --- Botão: Entrar com o Google ---
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(
                      color: Color(0xFF4B83AE),
                      width: 1.5,
                    ),
                  ),
                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 30,
                    color: Color(0xFF4B83AE),
                  ),
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