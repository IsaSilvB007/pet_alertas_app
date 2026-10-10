import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocaliza_app/view/avisos_view.dart';
import 'package:geolocaliza_app/view/emitir_alerta_view.dart';
import 'package:geolocaliza_app/view/gerenciar_alertas_view.dart';
import 'package:geolocaliza_app/view/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'view/cadastro_usuario_view.dart';
import 'view/login_view.dart';
import 'view/home_mapa_view.dart';
import 'view/redefinir_senha_view.dart';
import 'view/sobre_view.dart';

void main() {
  runApp(DevicePreview(builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AmparaPet',

      //
      // TEMA GLOBAL (Poppins + Cor do Inputbox)
      //
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B83AE),
          primary: const Color(0xFF4B83AE),
        ),

        //Fonte Poppins unificada para todo o app
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme),

        //Cursor e seleção de texto em azul
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4B83AE),
          selectionHandleColor: Color(0xFF4B83AE),
        ),
      ),



      //
      // ROTAS
      //

      initialRoute: 'home_view',
      routes: {
        'home_view': (context) => const HomeView(),
        'login': (context) => const LoginView(),
        'cadastro_usuario': (context) => const CadastroUsuarioView(),
        'home_mapa': (context) => const HomeMapaView(),
        'redefinir_senha': (context) => const RedefinirSenhaView(),
        'sobre': (context) => const SobreView(),
        'emitir_alerta':(context) => const EmitirAlertaView(),
        'avisos':(context) => const AvisosView(),
        'gerenciar_alertas':(context) => const GerenciarAlertasView(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => HomeView());
      },
    );
  }
}
