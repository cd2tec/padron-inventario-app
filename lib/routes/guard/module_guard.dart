import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/UserService.dart';

class ModuleGuard extends AutoRouteGuard {
  final String selectedModule;
  ModuleGuard({required this.selectedModule});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    UserService service = UserService();
    final context = router.navigatorKey.currentState!.overlay!.context;

    try {
      List<dynamic> modulesPermission = await service.hasModulesPermission();

      if (modulesPermission.isNotEmpty && modulesPermission.first.containsKey("modules")) {
        List<dynamic> modules = modulesPermission.first["modules"];

        if (modules.isEmpty) {
          _showSnackBar(context, "Usuário não possui módulos vinculados!");
          router.push(HomeRoute());
        }

        modules.forEach((element) {
          if (isValidOption(selectedModule, modules)) {
            resolver.next(true);
          }
        });

        _showSnackBar(context, "Usuário não tem permissão para acessar esse módulo.");
        router.push(HomeRoute());
      }
    } catch (errorOrException) {
      _showSnackBar(context, "$errorOrException");
      router.push(HomeRoute());
    }
  }

  bool isValidOption(String selectedOption, List<dynamic> modules) {
    return modules.any((module) => module['description'] == selectedOption);
  }

  void _showSnackBar(BuildContext context, String message) {
    Navigator.pop(context);

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
