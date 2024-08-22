import 'package:flutter/material.dart';

import '../constants/colors.dart';

class InfAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Remove o botão de voltar padrão
      backgroundColor: TColors.primaryColor,
      elevation: 0, // Remove a sombra do AppBar

      // Conteúdo do AppBar
      actions: [
        // Ícone à esquerda com espaçamento
        Container(
          padding: EdgeInsets.only(left: 50.0), // Espaçamento à esquerda
          child: IconButton(
            icon: Icon(Icons.manage_accounts),
            color: Colors.white, // Cor branca para o ícone
            iconSize: 30,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/gerenciamento');
            },
          ),
        ),

        // Ícone central com espaçamento
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.article),
              color: Colors.white, // Cor branca para o ícone
              iconSize: 30,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/publicacoes');
              },
            ),
          ),
        ),

        // Ícone à direita com espaçamento
        Container(
          padding: EdgeInsets.only(right: 50.0), // Espaçamento à direita
          child: IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white, // Cor branca para o ícone
            iconSize: 30,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/definicoes');
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
