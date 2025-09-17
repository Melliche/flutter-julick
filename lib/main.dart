import 'package:flutter/material.dart';
import 'package:test_1_flutter/screens/film_list_page.dart';
import 'package:test_1_flutter/screens/formulaire_page.dart';
import 'package:test_1_flutter/screens/home_page.dart';
import 'package:test_1_flutter/screens/screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Accueil'),
        '/settings': (context) => const Screen1(title: "Paramètres"),
        '/formulaire': (context) => const FormulairePage(title: "Formulaire"),
        '/films': (context) => const FilmListPage(),
      },
    );
  }
}
