import 'package:flutter/material.dart';
import 'dart:math';

class InvestimentoScreen extends StatefulWidget {
  const InvestimentoScreen({super.key});

  @override
  State<InvestimentoScreen> createState() => _InvestimentoScreenState();
}

class _InvestimentoScreenState extends State<InvestimentoScreen> {
  final TextEditingController _valorMensalController = TextEditingController();
  final TextEditingController _mesesController = TextEditingController();
  final TextEditingController _jurosMensalController = TextEditingController();

  void _calcularInvestimento() {
    final double? valorMensal = double.tryParse(_valorMensalController.text);
    final int? meses = int.tryParse(_mesesController.text);
    final double? jurosMensal = double.tryParse(_jurosMensalController.text);

    if (valorMensal == null || meses == null || jurosMensal == null) {
      _mostrarResultado('Erro', 'Preencha todos os campos com valores válidos.');
      return;
    }

    // Montante acumulado sem juros
    final montanteSemJuros = valorMensal * meses;

    // Montante com juros compostos
    final taxaMensalDecimal = jurosMensal / 100;
    final montanteComJuros = valorMensal * (pow(1 + taxaMensalDecimal, meses) - 1) / taxaMensalDecimal;

    String resultado = '''
Montante sem juros: R\$ ${montanteSemJuros.toStringAsFixed(2)}
Montante com juros compostos: R\$ ${montanteComJuros.toStringAsFixed(2)}
''';

    _mostrarResultado('Resultado do Investimento', resultado);
  }

  void _mostrarResultado(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _valorMensalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor mensal investido (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mesesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de meses',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _jurosMensalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Taxa de juros mensal (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularInvestimento,
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
