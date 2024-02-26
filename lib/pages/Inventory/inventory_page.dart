import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:padron_inventario_app/pages/Inventory/inventory_detail_page.dart';
import '../../services/InventoryService.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  InventoryService service = InventoryService();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productkeyController = TextEditingController();

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
          ElevatedButton(
            onPressed: () async {
              if (_productkeyController.text.isNotEmpty) {
                service.fetchProduct('produtoKey', _productkeyController.text).then((value) {
                  print(value);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryDetailPage(),
                    ),
                  );
                });
              } else {
                // Trate o caso em que o campo está vazio
                print("Campo de código de barras vazio");
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Buscar", style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
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

              print("Código de Barras: $barcodeScanRes");
              service.fetchProduct('gtin', _barcodeController.text).then((value) {
                print(value);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InventoryDetailPage(),
                  ),
                );
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Scanner", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

