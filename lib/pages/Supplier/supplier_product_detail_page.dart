import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/supplier/app_bar_title.dart';

@RoutePage()
class SupplierProductDetailPage extends StatefulWidget {
  final Map<String, dynamic>? productData;
  final Map<String, dynamic>? additionalData;

  const SupplierProductDetailPage({
    Key? key,
    this.productData,
    this.additionalData,
  }) : super(key: key);

  @override
  _SupplierProductDetailPageState createState() =>
      _SupplierProductDetailPageState();
}

class _SupplierProductDetailPageState extends State<SupplierProductDetailPage> {
  final _controllers = <String, TextEditingController>{};
  final _originalData = <String, dynamic>{};
  final _currentData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeData();
  }

  void _initializeControllers() {
    _controllers.addAll({
      'Saldo Disponivel':
          TextEditingController(text: _getStringValue('saldo_disponivel')),
    });
  }

  void _initializeData() {
    _originalData.addAll({
      'saldoDisponivel': _getStringValue('saldo_disponivel'),
    });
    _currentData.addAll(_originalData);
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const AppBarTitle(title: detailsOfProductTitle),
          backgroundColor: const Color(redColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCard(),
                const SizedBox(height: 20),
                for (final entry in _controllers.entries)
                  _buildTextFormField(entry.key, entry.value),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              _updateProductInInventory();
              Navigator.pop(context, {
                'gtin': widget.productData?['gtin'],
                'saldoDisponivel': _controllers['Saldo Disponivel']?.text,
                'flagUpdated': true,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(redColor),
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
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: const Color(redColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyField('Descrição:', _getStringValue('descricao')),
            _buildReadOnlyField('Divisão:', _getStringValue('divisao')),
            _buildReadOnlyField(
                'Código Produto:', _getStringValue('product_key')),
            _buildReadOnlyField('GTIN:', _getStringValue('gtin')),
            _buildReadOnlyField('Quantidade Exposição:',
                _getStringValue('quantidade_exposicao')),
            _buildReadOnlyField('Quantidade Ponto Extra:',
                _getStringValue('quantidade_ponto_extra')),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _currentData[removeSpecialCharacters(
                    labelText.toLowerCase().replaceAll(' ', ''))] =
                formatData(value);
          });
        },
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String labelText, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            labelText,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? '',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String? _getStringValue(String key) {
    if (widget.productData != null && widget.productData!.containsKey(key)) {
      if (key == 'quantidade_exposicao' || key == 'quantidade_ponto_extra') {
        return widget.productData![key]?.toString() ?? '0';
      }
      return widget.productData![key]?.toString();
    } else {
      return null;
    }
  }

  String removeSpecialCharacters(String text) {
    return text
        .replaceAll('ã', 'a')
        .replaceAll('õ', 'o')
        .replaceAll('â', 'a')
        .replaceAll(RegExp(r'[çÇ]'), 'c');
  }

  String formatData(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  void _updateProductInInventory() async {
    try {
      await SupplierService().updateProductLocalInventory(
        inventoryId: widget.additionalData?['inventoryId'],
        gtin: widget.productData?['gtin'],
        estoqueDisponivel: int.parse(_currentData['saldodisponivel']),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(changesSubmittedSuccessfully),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$errorSubmittingChanges $error'),
        ),
      );
    }
  }
}
