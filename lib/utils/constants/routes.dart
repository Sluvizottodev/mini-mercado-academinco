import 'package:flutter/material.dart';

import '../../Screens/HomeScreens/Cadastro.dart';
import '../../Screens/HomeScreens/Login.dart';
import '../../Screens/MainScreens/Catalogo.dart';

class PageRoutes {
  // Define todas as rotas do aplicativo como constantes
  static const String onboarding = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String catalogo = '/catalogo';
  static const String publicacoes = '/publicacoes';
  static const String definicoes = '/definicoes';

  // Método para gerar a rota baseada no nome
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case cadastro:
        return MaterialPageRoute(builder: (_) => CadastroScreen());
      case catalogo:
        return MaterialPageRoute(builder: (_) => CatalogoScreen());
      case publicacoes:
      // return MaterialPageRoute(builder: (_) => PublicacoesScreen());
      case definicoes:
      // return MaterialPageRoute(builder: (_) => DefinicoesScreen());
      default:
      // Não faz nada se a rota não for encontrada
        return MaterialPageRoute(builder: (_) => Container()); // Retornando um Container vazio
    }
  }
}
