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
        title: const Text(
          'Inventário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _productkeyController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Código do Produto',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          _scanProductKey(_productkeyController.text);
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
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
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Store>(
                      isDense: true,
                      value: selectedLoja,
                      style: const TextStyle(color: Colors.black),
                      items: [
                        const DropdownMenuItem<Store>(
                          value: null,
                          child: Center(child: Text("Selecionar Loja", style: TextStyle(fontSize: 16.0))),
                        ),
                        ...lojas.map((Store loja) {
                          return DropdownMenuItem<Store>(
                            value: loja,
                            child: Center(child: Text(loja.fantasia)),
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
                ),
              ),
            ],
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
    service.fetchProduct(filter, value, selectedLoja!.nroempresabluesoft).then((value) {
      Map<String, dynamic> decodedData = jsonDecode(value);
      var firstItem = decodedData['data'][0];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InventoryDetailPage(inventoryData: firstItem),
        ),
      );
    }).catchError((error) {
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
}
