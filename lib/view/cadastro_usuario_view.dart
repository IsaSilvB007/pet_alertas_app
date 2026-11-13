import 'package:flutter/material.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  // Controla se o perfil selecionado é ONG (true) ou Cidadão/Usuário (false)
  bool _isOng = false;
  bool _esconderSenha = true;

  // Controladores para todos os campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _razaoSocialController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _celularController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  // Função de Validação Geral (Email e CNPJ se for ONG)
  void _validarECriarConta() {
    String email = _emailController.text.trim();
    String cnpj = _cnpjController.text.trim();

    // Regex de Email
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    ).hasMatch(email);

    // Regex básica para formato de CNPJ (00.000.000/0000-00 ou apenas números)
    bool cnpjValid = RegExp(
      r"^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$|^\d{14}$"
    ).hasMatch(cnpj);

    if (email.isEmpty) {
      _mostrarAviso('Por favor, preencha o campo de e-mail.');
      return;
    }

    if (!emailValid) {
      _mostrarAviso('Insira um formato de e-mail válido (ex: exemplo@email.com).');
      return;
    }

    // Se for ONG, valida também o CNPJ
    if (_isOng) {
      if (cnpj.isEmpty) {
        _mostrarAviso('Por favor, preencha o CNPJ da instituição.');
        return;
      }
      if (!cnpjValid) {
        _mostrarAviso('Insira um CNPJ válido no formato 00.000.000/0000-00.');
        return;
      }
    }

    // Se estiver tudo correto, prossegue para o login (ou Firebase)
    Navigator.pushReplacementNamed(context, 'login');
  }

  void _mostrarAviso(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4B83AE);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'NOVO CADASTRO',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                  ),
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'Preencha os campos abaixo para começar.',
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                const SizedBox(height: 25),

                // --- SELETOR DE PERFIL (Abas) ---
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isOng = false),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !_isOng ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Sou Cidadão',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !_isOng ? Colors.white : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isOng = true),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _isOng ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Sou ONG',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _isOng ? Colors.white : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // --- CAMPOS DINÂMICOS COM KEY PARA EVITAR CRUZAÇÃO DE DADOS ---
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: !_isOng
                      ? Column(
                          key: const ValueKey('cidadao'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nome Completo',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _nomeController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          key: const ValueKey('ong'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Razão Social / Nome da ONG',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _razaoSocialController,
                              decoration: InputDecoration(
                                hintText: 'Nome da instituição',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'CNPJ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _cnpjController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '00.000.000/0000-00',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),

                const SizedBox(height: 20),

                // Campos comuns a ambos os perfis
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Celular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _celularController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Senha',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _senhaController,
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

                const SizedBox(height: 30),

                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _validarECriarConta,
                      child: const Text(
                        'CRIAR CONTA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: const Text('Já tem uma conta? Faça login'),
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