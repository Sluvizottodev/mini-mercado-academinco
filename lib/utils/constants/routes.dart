import 'package:flutter/material.dart';
import 'package:minimercado/Screens/MainScreens/Configuracao.dart';
import 'package:minimercado/Screens/MainScreens/Historico.dart';
import '../../Screens/HomeScreens/Cadastro.dart';
import '../../Screens/HomeScreens/Login.dart';
import '../../Screens/MainScreens/Cart.dart';
import '../../Screens/MainScreens/Catalogo.dart';
import '../../Screens/MainScreens/Checkout.dart'; // Importando CheckoutScreen
import '../../utils/models/Products.dart';

class PageRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String catalogo = '/catalogo';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String historico = '/historico';
  static const String config = '/configuracao';

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
        return MaterialPageRoute(builder: (_) => HistoricoComprasScreen());
      case checkout:
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(), // Chama a CheckoutScreen
        );
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? currentRoute) {
    if (currentRoute == login) {
      return MaterialPageRoute(builder: (context) {
        return AlertDialog(
          title: Text('Sair do App?'),
          content: Text('Deseja realmente sair do aplicativo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                // Implementar a lógica para sair do aplicativo
                // Exemplo: SystemNavigator.pop();
              },
              child: Text('Sair'),
            ),
          ],
        );
      });
    } else {
      return MaterialPageRoute(
        builder: (_) => CatalogoScreen(),
      );
    }
  }
}
