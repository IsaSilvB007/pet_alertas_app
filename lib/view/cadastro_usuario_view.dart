import 'package:flutter/material.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  bool _possuiDeficiencia = false;
  bool _esconderSenha = true;
  bool _esconderConfirmarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'NOVO CADASTRO',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Preencha os campos abaixo para começar.',
                  style: TextStyle(fontSize: 15),
                ),

                SizedBox(height: 20),

                Text(
                  'Nome Completo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Celular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Senha',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                TextField(
                  obscureText: _esconderSenha,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _esconderSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _esconderSenha = !_esconderSenha;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Confirmar Senha',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                TextField(
                  obscureText: _esconderConfirmarSenha,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _esconderConfirmarSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _esconderConfirmarSenha = !_esconderConfirmarSenha;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Possui alguma deficiência?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  activeThumbColor: const Color(0xFF4B83AE),
                  value: _possuiDeficiencia,
                  onChanged: (bool value) {
                    setState(() {
                      _possuiDeficiencia = value;
                    });
                  },
                ),

                SizedBox(height: 10),

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
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      child: Text(
                        'CRIAR CONTA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: Text('Já tem uma conta? Faça login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
