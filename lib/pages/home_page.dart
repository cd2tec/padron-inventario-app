import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final AuthService service = AuthService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          welcomeMessage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(redColor),
      ),
      drawer: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool isAdmin = snapshot.data?.getBool('isAdmin') ?? false;

            return buildDrawer(context, isAdmin);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Padron',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Perfumaria',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'APP Inventário V1.3.3',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Versão Debug',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context, bool isAdmin) {
    return Drawer(
      child: ListView(
        children: [
          if (isAdmin)
            ListTile(
              onTap: () {
                AutoRouter.of(context).push(const UserListRoute());
              },
              title: const Text(manageUsersTittle),
              leading: const Icon(Icons.supervised_user_circle),
            ),
          ListTile(
            onTap: () {
              AutoRouter.of(context)
                  .push(const InventoryRoute())
                  .catchError((error) {
                Navigator.pop(context);
              });
            },
            title: const Text(manageInventoryTittle),
            leading: const Icon(Icons.inventory),
          ),
          ListTile(
            onTap: () {
              AutoRouter.of(context)
                  .push(const SupplierRoute())
                  .catchError((error) {
                Navigator.pop(context);
              });
            },
            title: const Text(supplierByInventoryTitle),
            leading: const Icon(Icons.inventory),
          ),
          ListTile(
            onTap: () {
              _logout(context);
            },
            title: const Text(exitApp),
            leading: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    service.revokeToken(context).then((_) {
      return SharedPreferences.getInstance();
    }).then((prefs) {
      prefs.clear();
    }).catchError((error) {});
  }
}
