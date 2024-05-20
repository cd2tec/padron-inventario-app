import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_router.gr.dart';
import '../../services/InventoryService.dart';
import '../../widgets/notifications/snackbar_widgets.dart';

@RoutePage()
class SupplierDetailPage extends StatefulWidget {
  final Map<String, dynamic>? productData;

  const SupplierDetailPage({Key? key, this.productData}) : super(key: key);

  @override
  _SupplierDetailPageState createState() => _SupplierDetailPageState();
}

class _SupplierDetailPageState extends State<SupplierDetailPage> {
  InventoryService inventoryService = InventoryService();
  final _controllers = <String, TextEditingController>{};
  final _originalData = <String, dynamic>{};
  final _currentData = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeData();
  }

  void _initializeControllers() {
    _controllers.addAll({
      'Saldo Disponivel':
          TextEditingController(text: _getStringValue('qtdDisponivel')),
    });
  }

  void _initializeData() {
    _originalData.addAll({
      'saldodisponivel': _getStringValue('qtdDisponivel'),
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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AutoRouter.of(context).replace(const SupplierSearchProductRoute());
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
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: const Color(0xFFA30000),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyField('Loja (BlueSoft):', _getStringValue('lojaKey')),
            _buildReadOnlyField('GTIN:', _getStringValue('gtinPrincipal')),
            _buildReadOnlyField(
                'Código Produto:', _getStringValue('produtoKey')),
            _buildReadOnlyField('Descrição Produto:', ''),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text(
                _getStringValue('descricao')!,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
            _buildReadOnlyField(
                'Preço Normal:', _getStringValue('precoNormal')),
            _buildReadOnlyField(
                'Preço Fidelidade:', _getStringValue('precoFidelidade')),
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
      return widget.productData![key]?.toString();
    } else {
      return null;
    }
  }

  Widget _buildConfirmButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _confirmChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA30000),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Confirmar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
      ),
    );
  }

  void _confirmChanges() {
    setState(() {
      _isLoading = true;
    });

    final changes = <String, dynamic>{};
    Map<String, dynamic> product = {};

    final originalValue = _originalData['saldodisponivel'];
    final updatedValue = _currentData['saldodisponivel'];

    if (originalValue != updatedValue) {
      changes['saldodisponivel'] = updatedValue;
    }

    if (changes.isEmpty) {
      final errorSnackBar = ErrorSnackBar(message: 'Nenhum dado alterado!');
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);

      setState(() {
        _isLoading = false;
      });
      return;
    }

    product = {
      'lojaKey': _getStringValue('lojaKey') ?? '',
      'produtoKey': _getStringValue('produtoKey') ?? '',
      'gtin': _getStringValue('gtinPrincipal') ?? ''
    };

    _updateStockAvailable(changes, product);
  }

  void _updateStockAvailable(
      Map<String, dynamic> changes, Map<String, dynamic> product) {
    inventoryService.createInventory(changes, product).then((response) {
      setState(() {
        _isLoading = false;
      });

      final successSnackBar = SuccessSnackBar(
          message: 'Alteração Enviada Para Fila De Processamento!');
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);

      final confirmedProductGtin = _getStringValue('gtinPrincipal') ?? '';

      _storeConfirmedProductGtin(confirmedProductGtin);

      AutoRouter.of(context).pop();
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });

      final errorSnackBar =
          ErrorSnackBar(message: 'Erro Na Gravação Das Alterações!');
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    });
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

  Future<void> _storeConfirmedProductGtin(String gtin) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> confirmedGtins =
        prefs.getStringList('confirmed_gtins') ?? [];
    confirmedGtins.add(gtin);

    await prefs.setStringList('confirmed_gtins', confirmedGtins);
  }
}
