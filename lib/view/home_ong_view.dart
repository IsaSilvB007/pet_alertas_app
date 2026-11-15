import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeOngView extends StatelessWidget {
  const HomeOngView({super.key});

  // Função para simular/concluir o atendimento de um resgate
  Future<void> _concluirResgate(BuildContext context, String docId, String especie) async {
    try {
      await FirebaseFirestore.instance.collection('alertas').doc(docId).delete();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resgate de $especie concluído e removido da fila pendente!'),
            backgroundColor: Colors.green.shade700,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar alerta: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Fundo claro neutro para leitura de cards
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2A38),
        elevation: 0,
        automaticallyImplyLeading: false, // Remove completamente qualquer seta de voltar automática
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Painel de Gestão • ONG',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Coordenação de Resgates em Tempo Real',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          // Ícone de Notificações interativo
          IconButton(
            tooltip: 'Notificações',
            icon: const Icon(Icons.notifications_active_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Monitorização ativa: novos alertas aparecem instantaneamente na fila.'),
                  backgroundColor: Color(0xFF1E2A38),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
          // Botão rápido para trocar de perfil
          IconButton(
            tooltip: 'Trocar Perfil',
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('alertas')
            .orderBy('dataCriacao', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF7043)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar fila de resgates: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum alerta pendente no momento!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Todos os animais reportados já foram atendidos.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              final String especie = data['especie'] ?? 'Animal';
              final String saude = data['saude'] ?? 'Não informado';
              final String comportamento = data['comportamento'] ?? 'Não informado';
              final double lat = data['latitude'] ?? 0.0;
              final double lng = data['longitude'] ?? 0.0;
              final Timestamp? dataCriacao = data['dataCriacao'] as Timestamp?;
              final String dataFormatada = dataCriacao != null
                  ? dataCriacao.toDate().toString().substring(0, 16)
                  : 'Recente';

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabeçalho do Card: Espécie + Badge Pendente
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xFFFF7043),
                                radius: 18,
                                child: Icon(Icons.pets, color: Colors.white, size: 18),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                especie,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'PENDENTE',
                              style: TextStyle(
                                color: Colors.orange.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),

                      // Detalhes Clínicos e Comportamentais
                      _buildInfoRow(Icons.medical_services_outlined, 'Saúde:', saude),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.psychology_outlined, 'Comportamento:', comportamento),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        'Coordenadas:',
                        '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.access_time, 'Registado em:', dataFormatada),

                      const SizedBox(height: 16),

                      // Botão de Ação da ONG
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _concluirResgate(context, doc.id, especie),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2A38),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.check_circle, size: 18),
                          label: const Text(
                            'MARCAR COMO RESGATADO',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text(
          '$label ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}