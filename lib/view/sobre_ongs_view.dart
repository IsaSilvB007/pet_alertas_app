import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SobreOngsView extends StatelessWidget {
  const SobreOngsView({super.key});

  final List<Map<String, String>> _ongs = const [
    {
      'nome': 'Abrace Um Amigo',
      'cidade': 'Ribeirão Preto - SP',
      'descricao': 'Resgate, reabilitação física e psicológica, e mediação de adoções rigorosamente responsáveis.',
      'pix': '12.345.678/0001-90',
    },
    {
      'nome': 'Projeto Amigo dos Animais',
      'cidade': 'Dumont - SP',
      'descricao': 'Apoio a animais de rua, castração comunitária e feiras de adoção mensais na região.',
      'pix': '98.765.432/0001-12',
    },
    {
      'nome': 'Lar do Cão Abandonado',
      'cidade': 'Ribeirão Preto - SP',
      'descricao': 'Abrigo temporário e reabilitação de cães resgatados de situações de maus-tratos.',
      'pix': '45.678.901/0001-55',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB9DDF7), Color(0xFFFFC9CF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'ONGs PARCEIRAS',
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _ongs.length,
                  itemBuilder: (context, index) {
                    final ong = _ongs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xFFFF7043),
                                radius: 20,
                                child: Icon(Icons.pets, color: Colors.white, size: 18),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ong['nome']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      ong['cidade']!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Text(
                            ong['descricao']!,
                            style: const TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Chave PIX (CNPJ):',
                                      style: TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                    Text(
                                      ong['pix']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: ong['pix']!));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('PIX da ${ong['nome']} copiado!'),
                                        backgroundColor: const Color(0xFF1E293B),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF7043),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                  icon: const Icon(Icons.copy, size: 14),
                                  label: const Text('Copiar', style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}