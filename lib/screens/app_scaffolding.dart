import 'package:app_tp2/app/app_routes.dart';
import 'package:app_tp2/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

class AppScaffolding extends StatelessWidget {
  final String title;
  final Widget body;

  const AppScaffolding({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext ctx) {
    ThemeController themeController = ThemeController.instance;
    return AnimatedBuilder(
        animation: themeController,
        builder: (ctx, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            drawer: Drawer(
              child: Column(
                children: [

                  // Drawer header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Drawer items (menus)
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ...MenusNav.toListOfListTile(ctx),
                        const Divider(height: 1),
                        ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Deconnexion'),
                            onTap: () {
                              AuthService.logout();                                          // Clear the authentication state
                              Navigator.pushReplacementNamed(ctx, AppRoutes.loginPage.path); // Navigate to the selected page
                            }
                        )
                      ]
                    )
                  ),

                  // SafeArea to avoid bottom notches and such, with a SwitchListTile to toggle the theme
                  SafeArea(
                    top: false,
                    child: SwitchListTile(
                      value: themeController.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        themeController.setThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                      thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Icon(Icons.dark_mode);
                          }
                          return const Icon(Icons.light_mode);
                        },
                      ),
                    )
                  )
                ],
              ),
            ),
            body: body,
          );
        }
    );
  }

}


enum MenusNav {
  home(
    Icons.home,
    'Accueil',
    AppRoutes.homePage,
    false
  ),
  pointage(
    Icons.check_circle_outline,
    'Pointage',
    AppRoutes.pointagePage,
    false
  ),
  pointageHistory(
    Icons.history,
    'Historique de pointage',
    AppRoutes.pointageHistoryPage,
    false
  ),
  debug(
    Icons.build,
    "Debug",
    AppRoutes.debugPage,
    true
  );

  final IconData icon;
  final String title;
  final AppRoutes redirector;
  final bool adminOnly;

  const MenusNav(
      this.icon,
      this.title,
      this.redirector,
      this.adminOnly
  );

  ListTile toListTile(BuildContext ctx) {
    return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      if (ModalRoute.of(ctx)?.settings.name == redirector.path) {
        Navigator.pop(ctx); // Just close the drawer if we're already on the selected page
        return;
      }
      Navigator.pop(ctx); // Close the drawer
      Navigator.pushReplacementNamed(ctx, redirector.path); // Navigate to the selected page
    }
    );
  }

  static List<ListTile> toListOfListTile(BuildContext ctx) {
    if (AuthService.isAuthenticated && AuthService.isAdmin) {
      return MenusNav.values
          .map((menu) => menu.toListTile(ctx))
          .toList();
    }
    return MenusNav.values
        .where((menu) => !menu.adminOnly)
        .map((menu) => menu.toListTile(ctx))
        .toList();
  }
}