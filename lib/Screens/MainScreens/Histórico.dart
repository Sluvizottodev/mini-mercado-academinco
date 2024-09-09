import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimercado/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/componentes/CustomAppBar.dart';
import '../../utils/componentes/InfAppBar.dart';

class HistoricoComprasScreen extends StatefulWidget {
  @override
  _HistoricoComprasScreenState createState() => _HistoricoComprasScreenState();
}

class _HistoricoComprasScreenState extends State<HistoricoComprasScreen> {
  String nome = '';
  List<Map<String, dynamic>> _historicoCompras = [];

  @override
  void initState() {
    super.initState();
    _getUserName();
    _getHistoricoCompras();
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

  Future<void> _getHistoricoCompras() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot comprasSnapshot = await FirebaseFirestore.instance
          .collection('compras')
          .where('userId', isEqualTo: user.uid)
          .get();

      setState(() {
        _historicoCompras = comprasSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return '';
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? sair = await _showExitConfirmationDialog(context);
        return sair ?? false;
      },
      child: Scaffold(
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
                            'Aqui está o seu histórico de compras.',
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final compra = _historicoCompras[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              'Compra em ${compra['data']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: TColors.primaryColor,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text('Total: R\$ ${compra['total']}'),
                                SizedBox(height: 8),
                                Text('Itens: ${compra['itens'].join(', ')}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _historicoCompras.length,
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
