import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importando o Firebase core
import 'package:minimercado/utils/constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que os bindings sejam inicializados
  await Firebase.initializeApp(); // Inicializa o Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperPão App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: PageRoutes.login,
      onGenerateRoute: PageRoutes.generateRoute, // Usando o método de geração de rotas
    );
  }
}
