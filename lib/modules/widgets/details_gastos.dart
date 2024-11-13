import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/gastos/entities/gastos.dart';

class DetailsGasto extends StatelessWidget {
  final Gasto gasto;

  const DetailsGasto({super.key, required this.gasto});

  @override
  Widget build(BuildContext context) {
    String nivelGasto = '';
    if (gasto.precio < 500) {
      nivelGasto = 'Menor';
    } else if (gasto.precio >= 500 && gasto.precio < 1000) {
      nivelGasto = 'Cuidado';
    } else {
      nivelGasto = 'Alto';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del Gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gasto.descripcion, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Precio: \$${gasto.precio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('Nivel de Gasto: $nivelGasto', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}