import 'package:flutter/material.dart';

import '../../Service/AuthServiceFire.dart';
import '../../utils/componentes/TituloBarComp.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/validators.dart';
import 'Definicoes.dart';
import 'Login.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = '';

  void _register() async {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    String confirmaSenha = _confirmaSenhaController.text;

    // Validando os campos antes de prosseguir
    String? nomeError = TValidator.validateUsername(nome);
    String? emailError = TValidator.validateEmail(email);
    String? senhaError = TValidator.validatePassword(senha);

    if (nomeError != null || emailError != null || senhaError != null) {
      setState(() {
        _errorMessage = nomeError ?? emailError ?? senhaError!;
      });
      return;
    }

    if (senha != confirmaSenha) {
      setState(() {
        _errorMessage = 'As senhas não coincidem!';
      });
      return;
    }

    String? result = await _authService.register(email: email, senha: senha, nome: nome);
    if (result == null) {
      // Registro bem-sucedido, navegue para a tela de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = result; // Atualize a mensagem de erro se houver
      });
    }
  }

  void _openTermosCondicoes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermosCondicoesScreen()),
    );
  }

  void _openPoliticaPrivacidade() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PoliticaPrivacidadeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TituloPadrao(titulo: 'Cadastro'),
              SizedBox(height: 20.0),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  counterText: '', // Oculta o contador de caracteres
                ),
                maxLength: 15, // Limite de caracteres para o nome
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _confirmaSenhaController,
                decoration: InputDecoration(
                  labelText: 'Confirme a Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _register,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(color: TColors.textWhite, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Já tenho uma conta? Login',
                  style: TextStyle(color: TColors.secondaryColor),
                ),
              ),
              SizedBox(height: 20.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text('Ao se cadastrar você concorda com os '),
                  GestureDetector(
                    onTap: _openTermosCondicoes,
                    child: Text(
                      'termos/condições',
                      style: TextStyle(
                        color: TColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(' e '),
                  GestureDetector(
                    onTap: _openPoliticaPrivacidade,
                    child: Text(
                      'política de privacidade',
                      style: TextStyle(
                        color: TColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text('.'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
