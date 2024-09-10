import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/constants/colors.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final String _cidade = 'Nova Friburgo'; // Cidade fixa
  String? _bairro; // Nullable
  String _formaPagamento = 'Dinheiro';
  double _taxaEntrega = 15.0; // Taxa fixa para Nova Friburgo
  String _rua = '';
  String _numeroCasa = '';
  List<Map<String, dynamic>> _cart = []; // Carrinho inicializado como vazio

  final List<String> _bairrosNovaFriburgo = [
    'Centro',
    'Olaria',
    'Cascatinha',
    'Santa Teresa',
    'Vargem Alta',
    'Duas Pedras',
    'Riograndina',
    'Mury',
    'Córrego Dantas',
    'Campo do Coelho',
    'Lumiar',
    'Prado',
    'Jardim Ouro Preto',
    // Adicione mais bairros conforme necessário
  ];

  final TextEditingController _cidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cidadeController.text = _cidade; // Define a cidade no controller
  }

  double get _totalCarrinho {
    double total = _cart.fold(0.0, (sum, item) => sum + (item['preco'] * item['quantity']));
    return total + _taxaEntrega;
  }

  void _finalizarCompra() {
    if (_rua.isEmpty || _numeroCasa.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Campos obrigatórios'),
          content: Text('Por favor, preencha todos os campos obrigatórios (Rua e Número).'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return; // Retorna para não continuar com a compra
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Compra Finalizada'),
        content: Text('Sua compra foi finalizada com sucesso!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: TColors.textWhite)),
        backgroundColor: TColors.primaryColor,
        automaticallyImplyLeading: false, // Remove a seta de retorno
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Localização', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              enabled: false,
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            DropdownButtonFormField<String>(
              value: _bairro,
              hint: Text('Selecione o Bairro'),
              items: _bairrosNovaFriburgo.map((bairro) {
                return DropdownMenuItem(
                  value: bairro,
                  child: Text(bairro),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _bairro = value;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _rua = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Rua'),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 80,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _numeroCasa = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Número'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Forma de Pagamento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RadioListTile(
              title: Text('Dinheiro'),
              value: 'Dinheiro',
              groupValue: _formaPagamento,
              onChanged: (value) {
                setState(() {
                  _formaPagamento = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Cartão de Crédito'),
              value: 'Cartão de Crédito',
              groupValue: _formaPagamento,
              onChanged: (value) {
                setState(() {
                  _formaPagamento = value!;
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(height: 10),
            Text('Taxa de Entrega: R\$ ${NumberFormat('#,##0.00', 'pt_BR').format(_taxaEntrega)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _finalizarCompra,
                child: Text('Confirmar Compra'),
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
            ),
          ],
        ),
      ),
    );
  }
}
