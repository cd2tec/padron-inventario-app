import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/pages/User/user_management_details_page.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/services/UserService.dart';

import '../../routes/app_router.gr.dart';

@RoutePage()
class MappingKeys extends StatefulWidget {
  const MappingKeys({Key? key}) : super(key: key);

  @override
  _MappingKeysState createState() => _MappingKeysState();
}

class _MappingKeysState extends State<MappingKeys> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Mapeando teclas',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: const Column(),
    );
  }

}