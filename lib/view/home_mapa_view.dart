import 'package:flutter/material.dart';

class HomeMapaView extends StatefulWidget {
  const HomeMapaView({super.key});

  @override
  State<HomeMapaView> createState() => _HomeMapaViewState();
}

class _HomeMapaViewState extends State<HomeMapaView> {
  // 1. CHAVE PARA CONTROLAR O DRAWER PROGRAMATICAMENTE
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB9DDF7), Color(0xFFFFC9CF)],
              ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
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
                    leading: Icon(Icons.person, color: Color(0xFF1E293B)),
                    title: Text('Perfil do Usuário'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'perfil');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Color(0xFF1E293B)),
                    title: Text('Sobre o Projeto'),
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
          // CAMADA 1: CAMADA DE FUNDO
          _buildMapBackground(),

          // CAMADA 2: CIMA (HEADER + BUSCA + FILTROS)
          _buildHeaderOverlay(context, _scaffoldKey),

          // CAMADA 3: BAIXO (BOTÃO DE AÇÃO)
          _buildFloatingActionButton(context),
        ],
      ),
    );
  }
}

Widget _buildMapBackground() {
  return Positioned.fill(
    child: Image.asset('assets/images/map_layout.png', fit: BoxFit.cover),
  );
}

Widget _buildHeaderOverlay(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,

    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        color: Color(0xFF1E2A38),
      ),
      padding: EdgeInsets.all(12),
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
                  icon: Icon(Icons.menu, color: Colors.white),
                ),

                Text(
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
                      icon: Icon(Icons.notifications_none, color: Colors.white),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF7043),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            Container(
              height: 44,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),

              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Buscar um...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'sobre_ongs');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFF7043),
                      ),
                      child: Row(
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

                  SizedBox(width: 8),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'avisos');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white54),
                      ),
                      child: Row(
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

                  SizedBox(width: 8),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'gerenciar_alertas');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white54),
                      ),
                      child: Row(
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
      backgroundColor: Color(0xFFFF7043),
      icon: Icon(Icons.add, color: Colors.white),
      label: Text(
        'CRIAR ALERTA',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
