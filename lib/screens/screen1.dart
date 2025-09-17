import 'package:flutter/material.dart';
import 'package:test_1_flutter/widgets/scaffold.dart';
import 'package:test_1_flutter/widgets/skill.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key, required this.title});

  final String title;

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.title,

      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[const Skill()],
              );
            }
          },
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Données chargées';
  }
}
