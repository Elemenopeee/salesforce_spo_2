import 'dart:math';

import 'package:flutter/material.dart';

class Sector {
  final Color color;
  final double value;
  final String title;

  Sector({required this.color, required this.value, required this.title});
}


List<double> get randomNumbers {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 1; i <= 7; i++) {
    randomNumbers.add(random.nextDouble() * 100);
  }

  return randomNumbers;
}

List<Sector> get industrySectors {
  return [
    Sector(
        color:  Colors.blue,
        value: randomNumbers[0],
        title: 'Total Sale Guitar'),
    Sector(
        color: const Color(0xFF7FE3F0),
        value: randomNumbers[1],
        title: 'Minimum Sale Guitar'),

  ];
}