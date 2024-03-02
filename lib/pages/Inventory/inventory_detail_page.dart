import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            items: [
              _buildCard(
                title: 'Descrição',
                content: [
                  _buildText('Código Produto:', 'produtoKey'),
                  _buildText('GTIN:', 'gtinPrincipal'),
                  _buildText('Código Loja(Bluesoft):', 'lojaKey'),
                ],
              ),
              _buildCard(
                title: 'Dados de Estoque',
                content: [
                  _buildText('Saldo Online', 'saldoOnline'),
                  _buildText('Saldo Físico', 'saldoFisico'),
                  _buildText('Saldo Disponível', 'saldoDisponivel'),
                  _buildText('Dta. Atualização Ficha Estoque', 'dataAtualizacaoFichaEstoque'),
                  _buildText('Fator Estoque', 'fatorEstoque'),
                  _buildText('Qtd. Exposição', 'quantidadeExposicao'),
                  _buildText('Qtd. Ponto Extra', 'quantidadePontoExtra'),
                ],
              ),
            ],
            options: CarouselOptions(
              height: 730,
              autoPlay: false,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> content}) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      child: Card(
        color: const Color(0xFFA30000),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ...content,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String labelText, String dataKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          _getStringValue(dataKey) ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const Divider(  // Add a Divider after each label-value pair
          color: Colors.white,
          height: 20,  // Adjust the height as needed
          thickness: 2,  // Adjust the thickness as needed
        ),
      ],
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
