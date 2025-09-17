import 'package:flutter/material.dart';
import 'package:test_1_flutter/widgets/scaffold.dart';
import 'package:test_1_flutter/widgets/skill.dart';

class MyHomePage extends StatelessWidget {

  final String title;
  const MyHomePage({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Acceuil ici"),
            Image(
              image: AssetImage('assets/images/codeimage.png'),
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
