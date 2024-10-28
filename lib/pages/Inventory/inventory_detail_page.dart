import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:padron_inventario_app/constants/constants.dart';

import '../../routes/app_router.gr.dart';
import '../../services/InventoryService.dart';
import '../../utils/InventoryUtilsService.dart';
import '../../widgets/notifications/snackbar_widgets.dart';

@RoutePage()
class InventoryDetailPage extends StatefulWidget {
  final Map<String, dynamic>? productData;

  const InventoryDetailPage({Key? key, this.productData}) : super(key: key);

  @override
  _InventoryDetailPageState createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  InventoryService inventoryService = InventoryService();
  late InventoryUtilsService _utilsService;
  final _controllers = <String, TextEditingController>{};
  final _originalData = <String, dynamic>{};
  final _currentData = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _utilsService = InventoryUtilsService();
    _initializeControllers();
    _initializeData();
  }

  void _initializeControllers() {
    _controllers.addAll({
      'Quantidade':
          TextEditingController(text: _getStringValue('qtdDisponivel')),
      'Endereço': TextEditingController(text: _getStringValue('endereco')),
      'Saldo Disponivel':
          TextEditingController(text: _getStringValue('qtdDisponivel')),
      'Quantidade Ponto Extra':
          TextEditingController(text: _getStringValue('quantidadePontoExtra')),
      'Quantidade Exposição':
          TextEditingController(text: _getStringValue('quantidadeExposicao')),
      'Multiplo': TextEditingController(text: _getStringValue('multiplo')),
    });
  }

  void _initializeData() {
    _originalData.addAll({
      'saldodisponivel': _getStringValue('qtdDisponivel'),
      'quantidadeexposicao': _getStringValue('quantidadeExposicao'),
      'quantidadepontoextra': _getStringValue('quantidadePontoExtra'),
      'multiplo': _getStringValue('multiplo'),
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
    bool isStoreMatch = _getStringValue('lojaKey') == dotenv.env['STORE'];
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
          detailsTitle,
          style: TextStyle(color: Colors.white),
        ),
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
              if (isStoreMatch) ...[
                _buildTextFormField(
                  'Quantidade',
                  _controllers['Quantidade']!,
                ),
                _buildTextFormField(
                  'Endereço',
                  _controllers['Endereço']!,
                ),
              ] else ...[
                for (final entry in _controllers.entries)
                  _buildTextFormField(entry.key, entry.value),
              ],
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
      color: const Color(redColor),
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

  Widget _buildTextFormField(String labelText, TextEditingController controller,
      {bool editable = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        enabled: editable,
        onChanged: (value) {
          setState(() {
            _currentData[_utilsService.removeSpecialCharacters(
                    labelText.toLowerCase().replaceAll(' ', ''))] =
                _utilsService.formatData(value);
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
      // Regra dos múltiplos para exibição ao usuario
      if (key == 'quantidadeExposicao') {
        final department = widget.productData?['departamento'];

        if (widget.productData?[key] > 3 && int.parse(department) != 9) {
          widget.productData?[key] = widget.productData?[key] + 1;
        }

        if (int.parse(department) == 9) {
          switch (widget.productData?[key]) {
            case 3:
              widget.productData?[key] = 6;
              break;
            case 4:
              widget.productData?[key] = 10;
              break;
            case 7:
              widget.productData?[key] = 12;
              break;
            case 13:
              widget.productData?[key] = 18;
              break;
            case 19:
              widget.productData?[key] = 24;
              break;
            case 29:
              widget.productData?[key] = 36;
              break;
            default:
              break;
          }
        }
      }

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
          backgroundColor: const Color(redColor),
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

    if (_areMapsEqual(_currentData, _originalData)) {
      final errorSnackBar = ErrorSnackBar(message: 'Nenhum dado alterado!');
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      AutoRouter.of(context).push(const InventoryRoute());
      return;
    }

    final changes = <String, dynamic>{};
    Map<String, dynamic> product = {};

    _currentData.forEach((key, value) {
      final originalValue = _originalData[key];
      final updatedValue = value;

      String? saldoDisponivel;
      String? quantidadeExposicao;
      String? quantidadePontoExtra;
      String? multiplo;

      if (originalValue != updatedValue) {
        switch (key) {
          case 'saldodisponivel':
            saldoDisponivel = value;
            break;
          case 'quantidadeexposicao':
            quantidadeExposicao = value;
            break;
          case 'quantidadepontoextra':
            quantidadePontoExtra = value;
            break;
          case 'multiplo':
            multiplo = value;
            break;
        }
      }

      if (saldoDisponivel != null) {
        var saldoParse = int.parse(saldoDisponivel);
        var saldoOldParse = int.parse(_originalData['saldodisponivel']);

        changes['saldodisponivel'] = saldoParse.toString();
        changes['saldo_disponivel_old'] = saldoOldParse.toString();
      }

      if (quantidadeExposicao != null) {
        var exposicaoParse = int.parse(quantidadeExposicao!);
        changes['quantidadeexposicao'] = exposicaoParse.toString();
      }

      if (quantidadePontoExtra != null) {
        var pontoextraParse = int.parse(quantidadePontoExtra!);
        changes['quantidadepontoextra'] = pontoextraParse.toString();
      }

      changes['multiplo'] = multiplo.toString();
    });

    product = {
      'lojaKey': _getStringValue('lojaKey') ?? '',
      'produtoKey': _getStringValue('produtoKey') ?? '',
      'gtin': _getStringValue('gtinPrincipal') ?? ''
    };

    if (changes.isEmpty && product.isEmpty) {
      setState(() {
        _isLoading = false;
      });

      final errorSnackBar = ErrorSnackBar(message: 'Nenhum dado alterado!');
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }

    // Regra de múltiplos
    final updatedChanges = changes;
    if (changes.containsKey('quantidadeexposicao')) {
      var quantidadeexposicao = changes['quantidadeexposicao'];
      final department = widget.productData?['departamento'];
      final updatedChanges = _utilsService.multipleRules(
          quantidadeexposicao!, changes, department);
    } else {
      changes['multiplo'] = '2';
    }

    updatedChanges['saldodisponivel'] = '2';
    _updateStockAvailable(updatedChanges, product);
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
      AutoRouter.of(context).push(const InventoryRoute());
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });

      final errorSnackBar =
          ErrorSnackBar(message: 'Erro Na Gravação Das Alterações!');
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    });
  }

  bool _areMapsEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    if (map1.length != map2.length) return false;

    for (String key in map1.keys) {
      if (map1[key] != map2[key]) {
        return false;
      }
    }

    return true;
  }
}
