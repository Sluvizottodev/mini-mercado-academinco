import 'package:flutter/material.dart';
import '../../Service/AuthServiceFire.dart';
import '../../utils/componentes/TituloBarComp.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = '';

  void _login() async {
    String email = _emailController.text;
    String senha = _senhaController.text;
    String? result = await _authService.login(email: email, senha: senha);
    if (result == null) {
      Navigator.pushReplacementNamed(context, '/catalogo');
    } else {
      setState(() {
        _errorMessage = result;
      });
    }
  }

  void _mostrarDialogoRedefinirSenha() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController emailController = TextEditingController();
        String mensagem = '';

        return AlertDialog(
          title: Text('Redefinir Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: TSizes.md(context)),  // Aqui o context foi adicionado
              if (mensagem.isNotEmpty)
                Text(
                  mensagem,
                  style: TextStyle(
                      color: mensagem.contains('sucesso')
                          ? Colors.green
                          : Colors.red),
                ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Enviar'),
              onPressed: () async {
                String email = emailController.text;
                if (email.isEmpty) {
                  setState(() {
                    mensagem =
                    'Por favor, preencha o e-mail para redefinir a senha.';
                  });
                  return;
                }
                String? result =
                await _authService.redefinicaoSenha(email: email);
                setState(() {
                  mensagem = result == null
                      ? 'E-mail de redefinição de senha enviado com sucesso.'
                      : result;
                });
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundLight,
      body: SingleChildScrollView( // Torna a tela rolável
        child: Padding(
          padding: EdgeInsets.all(TSizes.lg(context)),  // Aqui o context foi adicionado
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TituloPadrao(titulo: 'Login', distanciaDoTopo: TSizes.xl(context)),  // Aqui o context foi adicionado
              SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Ajuste de tamanho dinâmico
              SizedBox(height: TSizes.xl(context)),  // Aqui o context foi adicionado
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: TSizes.md(context)),  // Aqui o context foi adicionado
              TextField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: TSizes.md(context)),  // Aqui o context foi adicionado
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: TSizes.sm(context)),  // Aqui o context foi adicionado
              ElevatedButton(
                onPressed: _login,
                child: Text('Logar',
                    style: TextStyle(
                        color: Colors.white, fontSize: TSizes.fontSizeXl(context))),  // Aqui o context foi adicionado
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: TSizes.sm(context)),  // Aqui o context foi adicionado
                ),
              ),
              SizedBox(height: TSizes.sm(context)),  // Aqui o context foi adicionado
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: Text('Cadastrar'),
                style: TextButton.styleFrom(
                  foregroundColor: TColors.secondaryColor,
                ),
              ),
              TextButton(
                onPressed: _mostrarDialogoRedefinirSenha,
                child: Text('Redefinir senha'),
                style: TextButton.styleFrom(
                  foregroundColor: TColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
