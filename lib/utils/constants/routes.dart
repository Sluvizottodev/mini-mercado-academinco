import 'package:flutter/material.dart';

import '../../Screens/HomeScreens/Cadastro.dart';
import '../../Screens/HomeScreens/Login.dart';
import '../../Screens/MainScreens/Cart.dart';
import '../../Screens/MainScreens/Catalogo.dart';
import '../../Screens/MainScreens/Checkout.dart';

class PageRoutes {
  // Define todas as rotas do aplicativo como constantes
  static const String onboarding = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String catalogo = '/catalogo';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
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
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case publicacoes:
      // return MaterialPageRoute(builder: (_) => PublicacoesScreen());
      case definicoes:
      // return MaterialPageRoute(builder: (_) => DefinicoesScreen());
      default:
      // Retorna um erro ou um Container vazio se a rota não for encontrada
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
