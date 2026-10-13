import 'package:flutter/material.dart';

class AvisosView extends StatefulWidget {
  const AvisosView({super.key});

  @override
  State<AvisosView> createState() => _AvisosViewState();
}

class _AvisosViewState extends State<AvisosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
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
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'MURAL DE AVISOS',
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
                        icon: Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
                      ),
                    ),
                    SizedBox(height: 48),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildAvisoCard(
                        titulo: 'FEIRA DE ADOÇÃO',
                        dataHora: 'Sábado 9h',
                        descricao:
                            'Traga RG e comprovante de residência. Vários cães e gatos estão esperando por você!',
                      ),

                      _buildAvisoCard(
                        titulo: 'CAMPANHA DE VACINAÇÃO',
                        dataHora: '31 de Maio - 13h30',
                        descricao:
                            'Vacinação antirrábica e V10 gratuita. Traga a carteirinha do seu pet.',
                      ),

                      _buildAvisoCard(
                        titulo: 'VOLUNTARIADO',
                        dataHora: '08 de Junho - 12h',
                        descricao:
                            'Mutirão de banho, passeio e carinho. Venha ajudar nossos resgatados!',
                      ),

                      _buildAvisoCard(
                        titulo: 'MUTIRÃO DE CASTRAÇÃO',
                        dataHora: '15 de Junho - 08h',
                        descricao:
                            'Triagem e agendamento para castração gratuita de cães e gatos de famílias de baixa renda.',
                      ),

                      _buildAvisoCard(
                        titulo: 'CAMPANHA DO AGASALHO & RAÇÃO',
                        dataHora: 'Até 20 de Junho',
                        descricao:
                            'Ponto de coleta aberto para doação de ração, cobertores, caminhas e medicamentos veterinários.',
                      ),
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

  Widget _buildAvisoCard({
    required String titulo,
    required String dataHora,
    required String descricao,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 4),
          Text(
            dataHora,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            descricao,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF475569),
              height: 1.3,
            ),
          ),
          SizedBox(height: 14),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7DD3FC),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            child: Text(
              'MAIS INFO',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
