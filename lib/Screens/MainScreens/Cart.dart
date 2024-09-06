import 'package:flutter/material.dart';
import '../../utils/models/Products.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho de Compras'),
        ),
        body: Center(
          child: Text('Nenhum item no carrinho'),
        ),
      );
    }

    final List<Product> _cart = args['cart'] ?? [];
    final Function _removeFromCart = args['removeFromCart'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: ListView.builder(
        itemCount: _cart.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_cart[i].imageUrl),
          ),
          title: Text(_cart[i].title),
          subtitle: Text('Preço: ${_cart[i].price}'),
          trailing: IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              _removeFromCart(_cart[i]);
              Navigator.popAndPushNamed(context, '/cart', arguments: {
                'cart': _cart,
                'removeFromCart': _removeFromCart,
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout', arguments: _cart);
        },
        child: Icon(Icons.payment),
      ),
    );
  }
}
