import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaConfiguracao extends StatelessWidget {
  const TelaConfiguracao({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Após o logout, navega para a tela de login
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Erro ao sair: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/catalogo');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _signOut(context); // Chama o método de logout
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              // Navega para a tela de perfil
              // Navigator.of(context).pushNamed('/perfil');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificações'),
            onTap: () {
              // Navega para a tela de notificações
              // Navigator.of(context).pushNamed('/notificacoes');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacidade'),
            onTap: () {
              // Navega para a tela de privacidade
              // Navigator.of(context).pushNamed('/privacidade');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ajuda'),
            onTap: () {
              // Navega para a tela de ajuda
              // Navigator.of(context).pushNamed('/ajuda');
            },
          ),
        ],
      ),
    );
  }
}
