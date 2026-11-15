import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class EmitirAlertaView extends StatefulWidget {
  const EmitirAlertaView({super.key});
  @override
  State<EmitirAlertaView> createState() => _EmitirAlertaViewState();
}

class _EmitirAlertaViewState extends State<EmitirAlertaView> {
  // Controladores para capturar os textos dos inputs
  final TextEditingController _especieController = TextEditingController();
  final TextEditingController _saudeController = TextEditingController();
  final TextEditingController _comportamentoController =
      TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _especieController.dispose();
    _saudeController.dispose();
    _comportamentoController.dispose();
    super.dispose();
  }

  // Função para salvar o alerta no Firebase Firestore
  Future<void> _publicarAlerta() async {
    setState(() => _isSaving = true);
    try {
      // 1. Obter localização GPS atual do utilizador (ou usar padrão de Ribeirão Preto se falhar)
      double latitude = -21.1775;
      double longitude = -47.8103;
      try {
        Position position = await Geolocator.getCurrentPosition();
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        debugPrint('Usando localização padrão devido a erro no GPS: $e');
      }

      // 2. Gravar no Firestore
      // 3. Gravar no Firestore
      await FirebaseFirestore.instance.collection('alertas').add({
        'especie': _especieController.text.trim(),
        'saude': _saudeController.text.trim(),
        'comportamento': _comportamentoController.text.trim(),
        'latitude': latitude,
        'longitude': longitude,
        'dataCriacao': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      // Mostra o aviso de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alerta publicado com sucesso! 🐾')),
      );

      // Pequena pausa de 600 milissegundos para a SnackBar aparecer e evitar o flash preto
      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao publicar alerta: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A38),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Emitir Alerta',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB9DDF7), Color(0xFFFFC9CF)],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. FOTO DO ANIMAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),

                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: 40,
                          color: Colors.white70,
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Adicionar foto do animal',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    '2. LOCALIZAÇÃO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.location_on,
                        color: Color(0xFFFF7043),
                        size: 36,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    '3. DETALHES',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _especieController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'ESPÉCIES (ex: Cão, Gato)',
                      hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF334155),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _saudeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'SAÚDE (ex: Ferido, Saudável)',
                      hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF334155),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _comportamentoController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'COMPORTAMENTO (ex: Assustado, dócil)',
                      hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF334155),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7043),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isSaving ? null : _publicarAlerta,
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'PUBLICAR ALERTA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
