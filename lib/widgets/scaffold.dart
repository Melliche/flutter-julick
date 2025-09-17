import 'package:flutter/material.dart';
import 'package:test_1_flutter/widgets/app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int likedCount;
  final bool showLikedCount;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.likedCount = 0,
    this.showLikedCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        /// Like pour les films sélectionnés
        actions: showLikedCount
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.favorite),
                      if (likedCount > 0)
                        Positioned(
                          right: -6,
                          top: -6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$likedCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ]
            : null,
      ),
      drawer: const AppDrawer(),
      body: body,
    );
  }
}
