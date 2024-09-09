import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimercado/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/componentes/CustomAppBar.dart';
import '../../utils/componentes/InfAppBar.dart';
import '../../utils/models/Products.dart';

class CatalogoScreen extends StatefulWidget {
  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Map<String, String>> topics = [
    {'name': 'Frutas', 'image': 'lib/utils/images/categories/frutas.png'},
    {'name': 'Legumes', 'image': 'lib/utils/images/categories/legumes.png'},
    {'name': 'Carnes', 'image': 'lib/utils/images/categories/carnes.png'},
    {'name': 'Laticínios', 'image': 'lib/utils/images/categories/laticinios.png'},
    {'name': 'Bebidas', 'image': 'lib/utils/images/categories/bebidas.png'},
    {'name': 'Higiene', 'image': 'lib/utils/images/categories/higiene.png'},
  ];

  String nome = '';
  List<Product> _cart = [];

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        nome = userDoc['nome'] ?? '';
      });
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return '';
    return s[0].toUpperCase() + s.substring(1);
  }

  Future<void> _addToCart(Product product) async {
    setState(() {
      // Verifica se o produto já está no carrinho e atualiza a quantidade ou adiciona um novo produto
      final existingProductIndex = _cart.indexWhere((item) => item.id == product.id);
      if (existingProductIndex >= 0) {
        _cart[existingProductIndex].quantity += 1; // Aumenta a quantidade
      } else {
        _cart.add(product.copyWith(quantity: 1)); // Adiciona novo produto com quantidade 1
      }
    });

    await _saveProductToCart(product);
    _showCartAlert(product);
  }

  Future<void> _saveProductToCart(Product product) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('cart').add({
        'productId': product.id,
        'title': product.title,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'userId': user.uid,  // Adicione o uid do usuário
      });
    }
  }

  Future<void> _showCartAlert(Product product) async {
    bool? goToCart = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Produto adicionado'),
          content: Text('O produto ${product.title} foi adicionado ao carrinho. Deseja ir para o carrinho agora?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Continuar comprando'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Ir para o carrinho'),
            ),
          ],
        );
      },
    );

    if (goToCart == true) {
      Navigator.pushNamed(context, '/cart', arguments: {
        'cart': _cart,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? sair = await _showExitConfirmationDialog(context);
        return sair ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  expandedHeight: 100.0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, ${capitalize(nome)}!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: TColors.secondaryColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Seja bem-vindo(a).',
                            style: TextStyle(
                              fontSize: 16,
                              color: TColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      height: 120.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    topics[index]['image']!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  topics[index]['name']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: TColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final product = products[index]; // Certifique-se de que 'products' está definido
                      return ProductItem(product, _addToCart); // Chamada correta para o item do produto
                    },
                    childCount: products.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: kToolbarHeight),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InfAppBar(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar saída'),
          content: Text('Você deseja sair do aplicativo?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
