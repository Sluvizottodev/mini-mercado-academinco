import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/constants/colors.dart';
import '../../utils/models/Products.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cart = [];
  double _totalAmount = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    _cart = [
      {'id': '1', 'quantity': 2},
      {'id': '3', 'quantity': 1},
    ];

    for (var item in _cart) {
      final product = products.firstWhere((prod) => prod.id == item['id']);
      item['title'] = product.title;
      item['price'] = product.price;
      item['imageUrl'] = product.imageUrl;
    }

    _calculateTotalAmount();
    setState(() {
      _isLoading = false;
    });
  }

  void _calculateTotalAmount() {
    setState(() {
      _totalAmount = _cart.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
    });
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      _cart[index]['quantity'] = (_cart[index]['quantity'] + delta).clamp(1, double.infinity).toInt();
      _calculateTotalAmount();
    });
  }

  void _removeFromCart(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remover Item'),
        content: Text('Você tem certeza que deseja remover este item do carrinho?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cart.removeAt(index);
                _calculateTotalAmount();
              });
              Navigator.of(ctx).pop();
            },
            child: Text('Remover'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho de Compras'),
          automaticallyImplyLeading: false, // Remove a seta de retorno
          backgroundColor: TColors.primaryColor, // Cor personalizada
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho de Compras'),
          automaticallyImplyLeading: false, // Remove a seta de retorno
          backgroundColor: TColors.primaryColor, // Cor personalizada
        ),
        body: Center(
          child: Text('Nenhum item no carrinho'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras' , style: TextStyle(color: TColors.textWhite , ),),
        automaticallyImplyLeading: false,
        backgroundColor: TColors.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (ctx, i) {
                final product = _cart[i];
                String formattedPrice = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(product['price'] * product['quantity']);
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(product['imageUrl']),
                    ),
                    title: Text(product['title']),
                    subtitle: Text(
                      'Preço Unitário: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(product['price'])}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _updateQuantity(i, -1),
                        ),
                        Text('${product['quantity']}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _updateQuantity(i, 1),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeFromCart(i),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity, // Barra inferior ocupando toda a largura da tela
            decoration: BoxDecoration(
              color: TColors.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30), // Ajusta o padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Faz o botão ocupar toda a largura
              children: [
                Text(
                  'Total: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(_totalAmount)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center, // Centraliza o texto
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  child: Text('Finalizar Compra'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.primaryColor,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15), // Preenche toda a largura disponível
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
