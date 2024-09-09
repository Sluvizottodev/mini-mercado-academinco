import 'package:flutter/material.dart';
import '../../utils/models/Products.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _locationController = TextEditingController();
  double deliveryFee = 0.0;

  @override
  Widget build(BuildContext context) {
    // Obtém os produtos do carrinho passados como argumentos
    final List<Product> _cart = ModalRoute.of(context)!.settings.arguments as List<Product>;
    double totalPrice = _cart.fold(0, (sum, product) => sum + product.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resumo do Pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _cart.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_cart[i].imageUrl),
                  ),
                  title: Text(_cart[i].title),
                  subtitle: Text('Preço: R\$ ${_cart[i].price.toStringAsFixed(2)}'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Total: R\$ ${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Insira sua localização'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String location = _locationController.text.trim();
                if (location.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, insira uma localização.')));
                  return;
                }

                if (location.toLowerCase() == 'nova friburgo') {
                  deliveryFee = 15.0;
                  double totalWithDelivery = totalPrice + deliveryFee;
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Pagamento'),
                      content: Text('Pagamento realizado com sucesso! Total com entrega: R\$ ${totalWithDelivery.toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entrega não disponível na sua localização.')));
                }
              },
              child: Text('Finalizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}
