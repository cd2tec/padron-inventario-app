import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart'; // Import CupertinoAlertDialog
import 'package:flutter/services.dart';
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart';

import '../../routes/app_router.gr.dart'; // Import SystemNavigator for app exit

@RoutePage()
class InventoryDetailPage extends StatefulWidget {
  final Map<String, dynamic>? productData;
  final Map<String, dynamic>? stockData;

  const InventoryDetailPage({Key? key, this.productData, this.stockData}) : super(key: key);

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
        leading: GestureDetector(
          onTap: () {
            AutoRouter.of(context).replace(const InventoryRoute());
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Detalhes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Expanded(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    items: [
                      _buildCard(
                        title: 'Dados de Estoque',
                        content: [
                          _buildText('Saldo Físico', 'saldoFisico'),
                          _buildText('Saldo Disponível', 'saldoDisponivel'),
                          _buildText('Qtd. Exposição', 'quantidadeExposicao'),
                          _buildText('Qtd. Ponto Extra', 'quantidadePontoExtra'),
                        ],
                      ),
                      _buildCard(
                        title: 'Descrição',
                        content: [
                          _buildText('Código Produto:', 'produtoKey'),
                          _buildText('GTIN:', 'gtinPrincipal'),
                          _buildText('Código Loja - Bluesoft:', 'lojaKey'),
                        ],
                      ),
                    ],
                    options: CarouselOptions(
                      height:  500,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA30000),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> content}) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      child: Card(
        color: const Color(0xFFBA2A25),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          _getStringValue(dataKey) ?? '',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        const Divider(
          color: Colors.white,
          height: 20,
          thickness: 2,
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
