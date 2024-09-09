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

  final List<Map<String, dynamic>> _itensCarrinho = [
    {'id': '1', 'nome': 'Maçã', 'preco': 1.50, 'quantity': 2},
    {'id': '2', 'nome': 'Alface', 'preco': 0.80, 'quantity': 1},
  ];

  double get _totalCarrinho {
    double total = _itensCarrinho.fold(0.0, (sum, item) => sum + (item['preco'] * item['quantity']));
    return total + _taxaEntrega;
  }

  void _finalizarCompra() {
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
      body: SingleChildScrollView( // Adiciona scroll se necessário
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Localização', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              enabled: false, // Desabilita o campo da cidade
              controller: TextEditingController(text: _cidade), // Define cidade como Nova Friburgo
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
                  _bairro = value; // Sem necessidade de null check aqui
                });
              },
            ),
            Row( // Usando Row para colocar Rua e Número da Casa na mesma linha
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
                SizedBox(width: 10), // Espaçamento entre os campos
                Container(
                  width: 80, // Largura fixa para o número da casa
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
            Text('Itens no Carrinho', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Desabilita rolagem do ListView
              itemCount: _itensCarrinho.length,
              itemBuilder: (context, index) {
                final item = _itensCarrinho[index];
                return ListTile(
                  title: Text('${item['nome']} (x${item['quantity']})'),
                  subtitle: Text('R\$ ${NumberFormat('#,##0.00', 'pt_BR').format(item['preco'] * item['quantity'])}'),
                );
              },
            ),
            SizedBox(height: 10),
            Text('Taxa de Entrega: R\$ ${NumberFormat('#,##0.00', 'pt_BR').format(_taxaEntrega)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Total: R\$ ${NumberFormat('#,##0.00', 'pt_BR').format(_totalCarrinho)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Estende o botão por toda a largura da tela
              child: ElevatedButton(
                onPressed: _finalizarCompra,
                child: Text('Confirmar Compra'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: TColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 18), // Aumenta o tamanho do texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
