import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/pages/Inventory/inventory_detail_page.dart';
import '../../services/InventoryService.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  InventoryService service = InventoryService();
  List<Store> lojas = [];
  Store? selectedLoja;
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productkeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStores();
  }

  Future<void> _fetchStores() async {
    List<Store> fetchedLojas = await service.fetchStores();
    setState(() {
      lojas = fetchedLojas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Inventário',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _openRegisterPage(context);
            },
          ),
        ],
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Estoque de Produtos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Buscar Produto',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.grey[300],
                        ),
                        child: TextField(
                          controller: _productkeyController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Código do Produto',
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {
                        _scanBarcode();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Selecionar Loja',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<Store>(
                            isDense: true,
                            value: selectedLoja,
                            style: const TextStyle(color: Colors.black),
                            items: [
                              ...lojas.map((Store loja) {
                                return DropdownMenuItem<Store>(
                                  value: loja,
                                  child: Center(
                                    child: Text(loja.fantasia),
                                  ),
                                );
                              }).toList(),
                            ],
                            onChanged: (Store? newValue) {
                              setState(() {
                                selectedLoja = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  _scanProductKey(_productkeyController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA30000),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  'Buscar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      true,
      ScanMode.DEFAULT,
    );

    if (!mounted) return;
    setState(() {
      _barcodeController.text = barcodeScanRes;
    });

    _searchProduct('gtin', _barcodeController.text);
  }

  Future<void> _scanProductKey(String productkey) async {
    if (productkey.isEmpty) return;
    _searchProduct('produtoKey', productkey);
  }

  void _searchProduct(String filter, String value) {
    service.fetchProduct(filter, value, selectedLoja!.nroempresabluesoft).then((productData) {
      print('productData');
      print(productData);

      service.fetchStock(filter, value, selectedLoja!.nroempresabluesoft).then((stockData) {
        print('stock');
        print(stockData);

        Map<String, dynamic> decodedProductData = jsonDecode(productData);
        Map<String, dynamic> decodedStockData = jsonDecode(stockData);

        // Ajuste para acessar a chave "data" corretamente
        Map<String, dynamic> productDataMap = decodedProductData['data'][0];
        Map<String, dynamic> stockDataMap = decodedStockData['data'][0];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryDetailPage(
              productData: productDataMap,
              stockData: stockDataMap,
            ),
          ),
        );
      }).catchError((error) {
        // Tratamento de erro para fetchStock
        print(error);
        final snackBar = SnackBar(
          content: Text(
            '$error',
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }).catchError((error) {
      // Tratamento de erro para fetchProduct
      print(error);
      final snackBar = SnackBar(
        content: Text(
          '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _openRegisterPage(BuildContext context) {
    if (ModalRoute.of(context)!.settings.name != "inventory") {
      Navigator.pushNamed(context, "inventory");
    }
  }

}
