import 'package:flutter/material.dart';
import 'ui/investimentos_screean.dart';

void main() {
  runApp(const InvestimentosApp());
}

class InvestimentosApp extends StatelessWidget {
  const InvestimentosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Investimentos',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const InvestimentoScreen(),
    );
  }
}
