import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:padron_inventario_app/services/UserService.dart';

class ModuleGuard extends AutoRouteGuard {
  final String selectedModule;
  ModuleGuard({required this.selectedModule});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    UserService service = UserService();
    try {
      List<dynamic> modulesPermission = await service.hasModulesPermission();


      if (modulesPermission.isNotEmpty && modulesPermission.first.containsKey("modules")) {
        List<dynamic> modules = modulesPermission.first["modules"];

        if (modules.isEmpty) {
          print("Usuário não possui módulos vinculados!");
          router.push(HomeRoute());
        }


        modules.forEach((element) {
          if (isValidOption(selectedModule, modules)) {
            resolver.next(true);
          } else {
            print("Usuário não tem permissão para acessar a opção escolhida. $element['description']");
            router.push(HomeRoute());
          }
        });
      }

    } catch (errorOrException) {
      print(errorOrException);
      router.push(HomeRoute());
    }
  }

  bool isValidOption(String selectedOption, List<dynamic> modules) {
    return modules.any((module) => module['description'] == selectedOption);
  }
}
