import 'package:flutter/material.dart';

class SobreOngsView extends StatefulWidget {
  const SobreOngsView({super.key});

  @override
  State<SobreOngsView> createState() => _SobreOngsViewState();
}

class _SobreOngsViewState extends State<SobreOngsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'PERFIL ONGS',
          style: TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Banner da ONG com bordas arredondadas e fundo limpo
                Container(
                  width: double.infinity,
                  height: 140,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/header_logo_ong.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Logo redonda da ONG
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo_ong.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.pets,
                        size: 40,
                        color: Color(0xFF1E5B5B),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 2. Nome da ONG
                const Text(
                  'ABRACE UM AMIGO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E5B5B),
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 10),

                // 3. Descrição institucional
                const Text(
                  'Transformar o cenário do abandono animal através do resgate, reabilitação física e psicológica, e da mediação de adoções rigorosamente responsáveis. Atuamos de forma prática para garantir a saúde de cães e gatos vulneráveis e conscientizar a sociedade sobre o manejo populacional e a guarda consciente.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Color(0xFF2D3748),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                // 4. Card de Doação via Pix
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7043),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'DOAÇÃO VIA PIX',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.qr_code_2,
                              size: 80,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 20),
                          TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.copy_rounded, size: 24),
                            label: const Text(
                              'Copiar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 5. Título da seção de pets
                const Text(
                  'CUIDADO: ALTO RISCO DE PAIXÃO!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 14),

                // 6. Linha com os cards dos animais
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPetCard('assets/images/pet4.jpg'),
                    _buildPetCard('assets/images/pet2.jpg'),
                    _buildPetCard('assets/images/pet3.jpg'),
                  ],
                ),

                // Margem inferior para a rolagem ser perfeita
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para os cards dos pets
  Widget _buildPetCard(String imagePath) {
    return Container(
      width: 95,
      height: 95,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.pets,
            color: Colors.grey,
            size: 40,
          ),
        ),
      ),
    );
  }
}