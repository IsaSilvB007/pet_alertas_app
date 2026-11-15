import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class HomeMapaView extends StatefulWidget {
  const HomeMapaView({super.key});

  @override
  State<HomeMapaView> createState() => _HomeMapaViewState();
}

class _HomeMapaViewState extends State<HomeMapaView> {
  // 1. CHAVE PARA CONTROLAR O DRAWER PROGRAMATICAMENTE
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 2. CONTROLADOR E COORDENADAS PARA O FLUTTER_MAP
  final MapController _mapController = MapController();
  LatLng _initialPosition = const LatLng(-21.1775, -47.8103); // Ribeirão Preto como padrão
  bool _loadingLocation = true;

  // 3. ESTADO DO ALERTA SELECIONADO PARA O POP-UP DE DETALHES
  Map<String, dynamic>? _alertaSelecionado;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // Função para obter a posição GPS atual
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _loadingLocation = false);
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _loadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _loadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _loadingLocation = false;
      });

      // Move a câmara do mapa para a posição do utilizador
      _mapController.move(_initialPosition, 15);
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
      setState(() => _loadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB9DDF7), Color(0xFFFFC9CF)],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                accountName: Text(
                  'Isadora Bispo',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  'isadora.bispo@aluno.frp.br',
                  style: TextStyle(color: Color(0xFF475569)),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFF334155),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFF1E293B)),
                title: const Text('Perfil do Usuário'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'perfil');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Color(0xFF1E293B)),
                title: const Text('Sobre o Projeto'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'sobre');
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // CAMADA 1: MAPA GRATUITO + LEITURA EM TEMPO REAL DO FIRESTORE
          Positioned.fill(
            child: _loadingLocation
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('alertas')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFF7043),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Erro ao carregar alertas: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final docs = snapshot.data?.docs ?? [];

                      // Conversão dos documentos em pins dinâmicos
                      final List<Marker> markers = docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final double lat = data['latitude'] ?? -21.1775;
                        final double lng = data['longitude'] ?? -47.8103;
                        final Timestamp? dataCriacao =
                            data['dataCriacao'] as Timestamp?;

                        return Marker(
                          point: LatLng(lat, lng),
                          width: 45,
                          height: 45,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _alertaSelecionado = {
                                  'especie': data['especie'] ?? 'Animal',
                                  'saude': data['saude'] ?? 'Não informado',
                                  'comportamento':
                                      data['comportamento'] ?? 'Não informado',
                                  'dataCriacao': dataCriacao != null
                                      ? dataCriacao
                                          .toDate()
                                          .toString()
                                          .substring(0, 16)
                                      : 'Recente',
                                };
                              });
                            },
                            child: const Icon(
                              Icons.location_pin,
                              color: Color(0xFFFF7043),
                              size: 45,
                            ),
                          ),
                        );
                      }).toList();

                      return FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _initialPosition,
                          initialZoom: 15,
                          onTap: (_, _) {
                            // Fecha o pop-up ao clicar no mapa vazio
                            if (_alertaSelecionado != null) {
                              setState(() => _alertaSelecionado = null);
                            }
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'com.example.geolocaliza_app',
                          ),
                          MarkerLayer(markers: markers),
                        ],
                      );
                    },
                  ),
          ),

          // CAMADA 2: HEADER + BUSCA + FILTROS
          _buildHeaderOverlay(context, _scaffoldKey),

          // CAMADA 3: BOTÃO DE AÇÃO (Esconde quando o pop-up está aberto para não sobrepor)
          if (_alertaSelecionado == null) _buildFloatingActionButton(context),

          // CAMADA 4: POP-UP DE DETALHES DO ALERTA SELECIONADO
          if (_alertaSelecionado != null)
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: Card(
                color: const Color(0xFF1E2A38),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.white24, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '🐾 Espécie: ${_alertaSelecionado!['especie']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white70,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() => _alertaSelecionado = null);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Saúde: ${_alertaSelecionado!['saude']}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Comportamento: ${_alertaSelecionado!['comportamento']}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Registado em: ${_alertaSelecionado!['dataCriacao']}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildHeaderOverlay(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        color: Color(0xFF1E2A38),
      ),
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),
                const Text(
                  'AmparaPet',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none,
                          color: Colors.white),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF7043),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 44,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Buscar um...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'sobre_ongs');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFFF7043),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.pets, size: 16, color: Colors.white),
                          SizedBox(width: 9),
                          Text(
                            'ONGs',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'avisos');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white54),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.campaign, size: 16, color: Colors.white),
                          SizedBox(width: 9),
                          Text(
                            'Avisos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'gerenciar_alertas');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white54),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.history, size: 16, color: Colors.white),
                          SizedBox(width: 9),
                          Text(
                            'Histórico',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFloatingActionButton(BuildContext context) {
  return Positioned(
    bottom: 24,
    right: 24,
    child: FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, 'emitir_alerta');
      },
      backgroundColor: const Color(0xFFFF7043),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'CRIAR ALERTA',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}