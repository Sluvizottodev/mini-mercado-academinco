import 'package:flutter/material.dart';
import 'package:minimercado/Screens/MainScreens/Configuracao.dart';
import 'package:minimercado/Screens/MainScreens/Historico.dart';

import '../../Screens/HomeScreens/Cadastro.dart';
import '../../Screens/HomeScreens/Login.dart';
import '../../Screens/MainScreens/Cart.dart';
import '../../Screens/MainScreens/Catalogo.dart';
import '../../Screens/MainScreens/Checkout.dart';
import '../../utils/models/Products.dart';

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
  static const String historico = '/historico';
  static const String config = '/configuracao';

  // Método para gerar a rota baseada no nome
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case config:
        return MaterialPageRoute(builder: (_) => TelaConfiguracao());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case cadastro:
        return MaterialPageRoute(builder: (_) => CadastroScreen());
      case catalogo:
        return MaterialPageRoute(builder: (_) => CatalogoScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case historico:
        return MaterialPageRoute(builder: (_) => HistoricoComprasScreen() );
      case checkout:
      // Verifica se os argumentos passados são uma lista de produtos
        if (settings.arguments is List<Product>) {
          final List<Product> cartProducts = settings.arguments as List<Product>;
          return MaterialPageRoute(builder: (_) => CheckoutScreen(), settings: RouteSettings(arguments: cartProducts));
        } else {
          return _errorRoute();
        }
      case publicacoes:
      // return MaterialPageRoute(builder: (_) => PublicacoesScreen());
      case definicoes:
      // return MaterialPageRoute(builder: (_) => DefinicoesScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('Rota não encontrada!'),
        ),
      ),
    );
  }
}
