import 'package:flutter/material.dart';
import 'package:minimercado/utils/constants/colors.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl, required String category,
  });
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function _addToCart;

  ProductItem(this.product, this._addToCart);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(product.imageUrl, fit: BoxFit.cover),
      footer: GridTileBar(
        backgroundColor: TColors.backgroundLight,
        title: Text(
          '${product.title} - \$${product.price.toStringAsFixed(2)}', // Exibe o preço junto ao título
          textAlign: TextAlign.center,
          style: TextStyle(
            color: TColors.textPrimary, // Define a cor do texto aqui
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart, color: TColors.primaryColor,),
          onPressed: () {
            _addToCart(product);
          },
        ),
      ),
    );
  }
}

// Exemplo de produtos
List<Product> products = [
  Product(id: '1', title: 'Maçã', price: 1.50, imageUrl: 'lib/utils/images/logo_branca.png', category: 'Frutas'),
  Product(id: '2', title: 'Banana', price: 1.20, imageUrl: 'lib/utils/images/logo_branca.png', category: 'Frutas'),
  Product(id: '3', title: 'Alface', price: 0.80, imageUrl: 'lib/utils/images/logo_branca.png', category: 'Legumes'),
  Product(id: '4', title: 'Tomate', price: 2.00, imageUrl: 'lib/utils/images/logo_branca.png', category: 'Legumes'),
  Product(id: '5', title: 'Peito de Frango', price: 10.00, imageUrl: 'lib/utils/images/chicken.png', category: 'Carnes'),
  Product(id: '6', title: 'Carne Bovina', price: 15.00, imageUrl: 'lib/utils/images/beef.png', category: 'Carnes'),
  Product(id: '7', title: 'Leite', price: 3.50, imageUrl: 'lib/utils/images/milk.png', category: 'Laticínios'),
  Product(id: '8', title: 'Queijo', price: 7.00, imageUrl: 'lib/utils/images/cheese.png', category: 'Laticínios'),
  Product(id: '9', title: 'Cerveja', price: 4.00, imageUrl: 'lib/utils/images/beer.png', category: 'Bebidas'),
  Product(id: '10', title: 'Suco de Laranja', price: 3.00, imageUrl: 'lib/utils/images/orange_juice.png', category: 'Bebidas'),
  Product(id: '11', title: 'Shampoo', price: 5.00, imageUrl: 'lib/utils/images/logo_branca.png', category: 'Higiene'),
  Product(id: '12', title: 'Sabonete', price: 2.50, imageUrl: 'lib/utils/images/logo_branca.png', category: 'Higiene'),
  // Adicione mais produtos conforme necessário
];