import 'dart:convert';
import 'package:flutter/material.dart';

class InventoryDetailPage extends StatefulWidget {
  final Map<String, dynamic>? productData;
  final Map<String, dynamic>? stockData;

  InventoryDetailPage({Key? key, this.productData, this.stockData}) : super(key: key);

  @override
  _InventoryDetailPageState createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  Map<String, dynamic> get _mappedProductData => widget.productData ?? {};
  Map<String, dynamic> get _mappedStockData => widget.stockData ?? {};


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
                  _buildText('Fator Estoque', 'fatorEstoque'),
                  _buildText('Qtd. Exposição', 'quantidadeExposicao'),
                  _buildText('Qtd. Ponto Extre', 'quantidadePontoExtra'),
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
    if (widget.productData != null && widget.productData!.containsKey(key)) {
      return widget.productData![key]?.toString();
    } else if (widget.stockData != null && widget.stockData!.containsKey(key)) {
      return widget.stockData![key]?.toString();
    } else {
      return null;
    }
  }
}
