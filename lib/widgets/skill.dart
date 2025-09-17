import 'package:flutter/material.dart';
import 'package:test_1_flutter/widgets/gauge.dart';

Map<String, double> skills = {
  "Flutter": 0.4,
  "Dart": 0.7,
  "Javascript": 0.6,
  "Python": 0.8,
  "C++": 0.5,
  "HTML/CSS": 0.9,
};

class Skill extends StatelessWidget {
  const Skill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Skills',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        for (var skill in skills.entries)
          Gauge(skill.key, skill.value),
      ],
    );
  }
}
