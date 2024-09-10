import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/constants/colors.dart';

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
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: user.uid)
          .get();

      _cart.clear(); // Clear the cart before loading items
      for (var doc in cartSnapshot.docs) {
        Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
        _cart.add({
          'id': item['productId'],
          'title': item['title'],
          'price': item['price'],
          'imageUrl': item['imageUrl'],
          'quantity': item['quantity'] ?? 1 // Use quantity from Firestore
        });
      }
    }
    _calculateTotalAmount();
    setState(() {
      _isLoading = false;
    });
  }

  void _calculateTotalAmount() {
    _totalAmount = _cart.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      _cart[index]['quantity'] = (_cart[index]['quantity'] + delta).clamp(1, double.infinity).toInt();
    });
    _calculateTotalAmount();
  }

  Future<void> _removeFromCart(int index) async {
    final productId = _cart[index]['id'];
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: user.uid)
          .where('productId', isEqualTo: productId)
          .get();

      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      setState(() {
        _cart.removeAt(index);
      });
      _calculateTotalAmount();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho de Compras'),
          automaticallyImplyLeading: false,
          backgroundColor: TColors.primaryColor,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho de Compras'),
          automaticallyImplyLeading: false,
          backgroundColor: TColors.primaryColor,
        ),
        body: Center(
          child: Text('Nenhum item no carrinho'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras', style: TextStyle(color: TColors.textWhite)),
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
            width: double.infinity,
            decoration: BoxDecoration(
              color: TColors.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(_totalAmount)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout', arguments: {
                      'cart': _cart,
                      'taxaEntrega': 15.0 // Passando a taxa de entrega
                    });
                  },
                  child: Text('Finalizar Compra'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.primaryColor,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
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
