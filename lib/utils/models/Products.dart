import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimercado/utils/constants/colors.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String category;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.quantity = 1,
  });

  Product copyWith({int? quantity}) {
    return Product(
      id: this.id,
      title: this.title,
      price: this.price,
      imageUrl: this.imageUrl,
      category: this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  // Método para criar um Product a partir de um documento do Firestore
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      title: data['title'] ?? '',
      price: data['price'] ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      quantity: data['quantity'] ?? 1,
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Future<void> Function(Product) addToCart;

  ProductItem(this.product, this.addToCart);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: GridTile(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(product.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: TColors.backgroundLight,
          title: Text(
            '${product.title} - R\$${product.price.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: TColors.textPrimary,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart, color: TColors.primaryColor),
            onPressed: () {
              _showAddToCartDialog(context, product);
            },
          ),
        ),
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Adicionar ao Carrinho'),
        content: Text('Deseja adicionar ${product.title} ao carrinho?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} adicionado ao carrinho!'),
                ),
              );
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}

// Função para adicionar ao carrinho
Future<void> addToCart(Product product) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  final uid = user.uid;

  // Referência ao Firestore
  final cartRef = FirebaseFirestore.instance.collection('cart').doc(uid);

  // Verifica se o produto já está no carrinho
  final cartSnapshot = await cartRef.get();
  if (cartSnapshot.exists) {
    // Se o carrinho já existe, atualiza a quantidade do produto
    List<dynamic> productsInCart = cartSnapshot['products'] ?? [];
    final existingProductIndex = productsInCart.indexWhere((item) => item['id'] == product.id);

    if (existingProductIndex >= 0) {
      // Atualiza a quantidade do produto existente
      productsInCart[existingProductIndex]['quantity'] += 1;
      await cartRef.update({'products': productsInCart});
    } else {
      // Adiciona novo produto ao carrinho
      await cartRef.update({
        'products': FieldValue.arrayUnion([
          {
            'id': product.id,
            'title': product.title,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'category': product.category,
            'quantity': 1,
          }
        ])
      });
    }
  } else {
    // Se o carrinho não existe, cria um novo
    await cartRef.set({
      'products': [
        {
          'id': product.id,
          'title': product.title,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'category': product.category,
          'quantity': 1,
        }
      ]
    });
  }
}

// Função para carregar o carrinho
Future<List<dynamic>> loadCart() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return [];
  }

  final uid = user.uid;

  // Referência ao Firestore
  final cartRef = FirebaseFirestore.instance.collection('cart').doc(uid);
  final cartSnapshot = await cartRef.get();

  if (cartSnapshot.exists) {
    return cartSnapshot['products'] ?? [];
  }

  return [];
}

// Produtos de exibição
List<Product> products = [
  Product(id: '1', title: 'Maçã', price: 1.50, imageUrl: 'lib/utils/images/maca.png', category: 'Frutas'),
  Product(id: '2', title: 'Banana', price: 1.20, imageUrl: 'lib/utils/images/banana.png', category: 'Frutas'),
  Product(id: '3', title: 'Alface', price: 0.80, imageUrl: 'lib/utils/images/alface.png', category: 'Legumes'),
  Product(id: '4', title: 'Tomate', price: 2.00, imageUrl: 'lib/utils/images/tomate.png', category: 'Legumes'),
  Product(id: '5', title: 'Frango', price: 10.00, imageUrl: 'lib/utils/images/frango.png', category: 'Carnes'),
  Product(id: '6', title: 'Carne Bovina', price: 15.00, imageUrl: 'lib/utils/images/carne.png', category: 'Carnes'),
  Product(id: '7', title: 'Leite', price: 3.50, imageUrl: 'lib/utils/images/leite.png', category: 'Laticínios'),
];
