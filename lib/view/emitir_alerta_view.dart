import 'package:flutter/material.dart';

class EmitirAlertaView extends StatefulWidget {
  const EmitirAlertaView({super.key});

  @override
  State<EmitirAlertaView> createState() => _EmitirAlertaViewState();
}

class _EmitirAlertaViewState extends State<EmitirAlertaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, 'home_mapa');
          }),
        title: Text(
          'Emitir Alerta',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB9DDF7),
              Color(0xFFFFC9CF),
            ],
          )
        ),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. FOTO DO ANIMAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 8),

                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF334155),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24, width: 1.5),
                  ),

                  child: Column(
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

                SizedBox(height: 20),

                Text(
                  '2. LOCALIZAÇÃO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 8),

                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF334155),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24, width: 1.5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_on,
                      color: Color(0xFFFF7043),
                      size: 36,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  '3. DETALHES',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 8),

                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ESPÉCIES',
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    filled: true,
                    fillColor: Color(0xFF334155),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white24),
                    )
                  ),
                ),

                SizedBox(height: 8),

                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'SAÚDE',
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    filled: true,
                    fillColor: Color(0xFF334155),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white24),
                    )
                  ),
                ),

                SizedBox(height: 8),

                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'COMPORTAMENTO',
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    filled: true,
                    fillColor: Color(0xFF334155),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white24),
                    )
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF7043),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                    onPressed: () {}, 
                    child: Text(
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
