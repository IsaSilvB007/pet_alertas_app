import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmitirAlertaView extends StatefulWidget {
  const EmitirAlertaView({super.key});

  @override
  State<EmitirAlertaView> createState() => _EmitirAlertaViewState();
}

class _EmitirAlertaViewState extends State<EmitirAlertaView> {
  // Controladores para recolher os dados dos campos
  final TextEditingController _especieController = TextEditingController();
  final TextEditingController _saudeController = TextEditingController();
  final TextEditingController _comportamentoController = TextEditingController();

  bool _isLoading = false;

  Future<void> _publicarAlerta() async {
    // Validação para garantir que tudo está preenchido
    if (_especieController.text.trim().isEmpty ||
        _saudeController.text.trim().isEmpty ||
        _comportamentoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os detalhes do animal!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Registo real no Firestore
      await FirebaseFirestore.instance.collection('alertas').add({
        'especie': _especieController.text.trim(),
        'saude': _saudeController.text.trim(),
        'comportamento': _comportamentoController.text.trim(),
        'status': 'Pendente',
        'dataCriacao': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alerta publicado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao publicar alerta: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              // Cabeçalho
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'Emitir Alerta',
                      style: TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1. FOTO DO ANIMAL',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF4B5563)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D3748),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, color: Colors.white, size: 36),
                            SizedBox(height: 8),
                            Text(
                              'Adicionar foto do animal',
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '2. LOCALIZAÇÃO',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF4B5563)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
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
                        child: const Row(
                          children: [
                            Icon(Icons.gps_fixed, color: Color(0xFFFF7043), size: 22),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Localização GPS Capturada',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Coordenadas obtidas com sucesso a partir do mapa.',
                                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '3. DETALHES',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF4B5563)),
                      ),
                      const SizedBox(height: 8),
                      
                      // Campos de Texto com espaçamento adequado e limpos
                      TextField(
                        controller: _especieController,
                        decoration: InputDecoration(
                          hintText: 'ESPÉCIES (ex: Cão, Gato)',
                          filled: true,
                          fillColor: const Color(0xFF2D3748),
                          hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12), // Espaçamento aplicado aqui!
                      TextField(
                        controller: _saudeController,
                        decoration: InputDecoration(
                          hintText: 'SAÚDE (ex: Ferido, Saudável)',
                          filled: true,
                          fillColor: const Color(0xFF2D3748),
                          hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12), // Espaçamento aplicado aqui!
                      TextField(
                        controller: _comportamentoController,
                        decoration: InputDecoration(
                          hintText: 'COMPORTAMENTO (ex: Assustado, dócil)',
                          filled: true,
                          fillColor: const Color(0xFF2D3748),
                          hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 60),

                      // Botão Publicar com verificação de loading
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _publicarAlerta,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF7043),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'PUBLICAR ALERTA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                        ),
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
}