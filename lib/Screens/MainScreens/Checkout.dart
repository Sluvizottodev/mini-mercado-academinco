import 'package:flutter/material.dart';

import '../../utils/models/Products.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> _cart = ModalRoute.of(context)!.settings.arguments as List<Product>;
    double totalPrice = _cart.fold(0, (sum, product) => sum + product.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Resumo do Pedido'),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _cart.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_cart[i].imageUrl),
                ),
                title: Text(_cart[i].title),
                subtitle: Text('Preço: ${_cart[i].price}'),
              ),
            ),
            SizedBox(height: 20),
            Text('Total: R\$ ${totalPrice.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Pagamento realizado com sucesso!');
              },
              child: Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}