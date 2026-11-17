import 'package:flutter/material.dart';

class PerfilController {
  // Notifiers para manter o nome e o email reativos na app inteira
  static final ValueNotifier<String> nomeUsuario = ValueNotifier<String>('Isadora Bispo');
  static final ValueNotifier<String> emailUsuario = ValueNotifier<String>('isadora.bispo@aluno.frp.br');

  // Função de validação e salvamento
  static bool atualizarNome(BuildContext context, String novoNome) {
    final nomeTratado = novoNome.trim();

    if (nomeTratado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O nome do usuário não pode estar vazio!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return false;
    }

    nomeUsuario.value = nomeTratado;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil atualizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    return true;
  }
}