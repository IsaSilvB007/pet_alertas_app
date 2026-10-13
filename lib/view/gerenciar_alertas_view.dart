import 'package:flutter/material.dart';

class GerenciarAlertasView extends StatefulWidget {
  const GerenciarAlertasView({super.key});

  @override
  State<GerenciarAlertasView> createState() => _GerenciarAlertasViewState();
}

class _GerenciarAlertasViewState extends State<GerenciarAlertasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'GERENCIAR ALERTAS',
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
                  ],
                ),
              ),

              SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildAlertaCard(
                        especie: 'Cão • Macho • Adulto',
                        localizacao: 'Rua das Flores, 123 - Centro',
                        status: 'Pendente',
                        statusColor: Colors.orange,
                      ),
                      _buildAlertaCard(
                        especie: 'Gato • Fêmea • Filhote',
                        localizacao: 'Av. Brasil, 456 - Jardim América',
                        status: 'Urgente',
                        statusColor: Colors.redAccent,
                      ),
                      _buildAlertaCard(
                        especie: 'Cão • Fêmea • Idoso',
                        localizacao: 'Praça da Matriz, s/n',
                        status: 'Em análise',
                        statusColor: Colors.blueAccent,
                      ),
                      _buildAlertaCard(
                        especie: 'Cão • Macho • Filhote',
                        localizacao: 'Rua XV de Novembro, 890 - Vila Tibério',
                        status: 'Urgente',
                        statusColor: Colors.redAccent,
                      ),
                      _buildAlertaCard(
                        especie: 'Gato • Macho • Adulto',
                        localizacao:
                            'Av. Independência, 1500 - Alto da Boa Vista',
                        status: 'Em análise',
                        statusColor: Colors.blueAccent,
                      ),
                      _buildAlertaCard(
                        especie: 'Cão • Fêmea • Adulto',
                        localizacao: 'Rua Américo Brasiliense, 321 - Centro',
                        status: 'Pendente',
                        statusColor: Colors.orange,
                      ),
                      _buildAlertaCard(
                        especie: 'Gato • Fêmea • Idoso',
                        localizacao: 'Av. João Fiúsa, 2200 - Jardim Irajá',
                        status: 'Urgente',
                        statusColor: Colors.redAccent,
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

  Widget _buildAlertaCard({
    required String especie,
    required String localizacao,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                especie,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Color(0xFF64748B)),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  localizacao,
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFEF4444)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'REJEITAR',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF34D399),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'APROVAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
