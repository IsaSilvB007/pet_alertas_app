import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'SOBRE O PROJETO',
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
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
                          children: const [
                            Icon(Icons.pets, size: 48, color: Color(0xFFFF7043)),
                            SizedBox(height: 8),
                            Text(
                              'AmparaPet',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              'Versão 1.0.0',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        titulo: 'Objetivo do Aplicativo',
                        icone: Icons.center_focus_strong,
                        conteudo:
                            'O AmparaPet é uma plataforma multiplataforma desenvolvida para conectar cidadãos, ONGs e protetores independentes no resgate e localização de animais em situação de rua ou abandonados via geolocalização.',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        titulo: 'Equipe de Desenvolvimento',
                        icone: Icons.group,
                        conteudo: '• Isadora da Silva Bispo',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        titulo: 'Professor Orientador',
                        icone: Icons.record_voice_over,
                        conteudo:
                            'Prof. Dr. Rodrigo de Oliveira Plotze',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        titulo: 'Informações Institucionais',
                        icone: Icons.school,
                        conteudo:
                            '• Instituição: FATEC Ribeirão Preto\n'
                            '• Curso: Análise e Desenvolvimento de Sistemas (ADS)\n'
                            '• Disciplina: Programação para Dispositivos Móveis',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String titulo,
    required IconData icone,
    required String conteudo,
    TextAlign textAlign = TextAlign.justify,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
              Icon(icone, size: 20, color: const Color(0xFFFF7043)),
              const SizedBox(width: 8),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: Color(0xFFE2E8F0)),
          Text(
            conteudo,
            textAlign: textAlign,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}