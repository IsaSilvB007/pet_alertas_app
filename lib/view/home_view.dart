import 'package:flutter/material.dart';
import '../widgets/botao_home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Spacer(),

                Image.asset('assets/images/logo_amparapet.png', height: 280),

                Spacer(),

                BotaoHome(
                  texto: 'ENTRAR',
                  cor: const Color(0xFF4B83AE),
                  icone: Icons.arrow_forward,
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                ),

                const SizedBox(height: 30),

                BotaoHome(
                  texto: 'CADASTRE-SE',
                  cor: const Color(0xFFFA9F86),
                  icone: Icons.person_add,
                  onPressed: () {
                    Navigator.pushNamed(context, 'cadastro_usuario');
                  },
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
