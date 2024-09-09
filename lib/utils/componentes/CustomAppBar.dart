import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {


  CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TColors.primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Ícone para histórico de compras
          IconButton(
            icon: Icon(Icons.history, color: Colors.white ,  size: 25,),
            onPressed: () {
              // Navegar para a tela de histórico de compras
              Navigator.pushNamed(context, '/historico'); // Substitua pela sua rota
            },
          ),
          // Logo centralizada
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/utils/images/logo_branca.png', // Substitua pelo caminho da sua logo
                  height: 35,
                ),
                SizedBox(width: 8), // Espaço entre a logo e o título
              ],
            ),
          ),
          // Ícone do carrinho de compras
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white, size: 25,),
            onPressed: () {
              // Navegar para a tela do carrinho de compras
              Navigator.pushNamed(context, '/cart'); // Substitua pela sua rota
            },
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
