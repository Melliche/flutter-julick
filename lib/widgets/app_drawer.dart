import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              child: UserAccountsDrawerHeader(
                accountName: const Text('Mounied'),
                accountEmail: const Text('MELLAH'),
                currentAccountPicture: const CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage('assets/images/codeimage.png'),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Formulaire'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/formulaire');
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Films'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/films');
              },
            ),
          ],
        ),
      ),
    );
  }
}
