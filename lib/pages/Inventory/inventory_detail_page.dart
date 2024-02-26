import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDetailPage extends StatefulWidget {
  final Map<String, dynamic>? inventoryData;

  InventoryDetailPage({Key? key, this.inventoryData}) : super(key: key);

  @override
  _InventoryDetailPageState createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  Map<String, dynamic> get _mappedData => widget.inventoryData ?? {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  _buildText('Código Produto:', 'produtoKey'),
                  _buildText('Código de Barras(gtin):', 'gtinPrincipal'),
                  _buildText('Código Loja(Bluesoft):', 'lojaKey'),
                ],
              ),
            ),
          ),
          // Card para dados de estoque
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dados de Estoque',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  _buildText('Saldo Online', 'saldoOnline'),
                  _buildText('Saldo Físico', 'saldoFisico'),
                  _buildText('Saldo Disponível', 'saldoDisponivel'),
                  _buildText('Saldo Estoque Contábil', 'saldoEstoqueContabil'),
                  _buildText('Dta. Atualização Ficha Estoque', 'dataAtualizacaoFichaEstoque'),
                  _buildText('Fato Estoque', 'fatorEstoque'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String labelText, String dataKey) {
    return Text(
      '$labelText: ${_getStringValue(dataKey) ?? ''}',
      style: const TextStyle(fontSize: 16),
    );
  }

  String? _getStringValue(String key) {
    return widget.inventoryData?[key]?.toString();
  }
}
