import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/gastos/entities/gastos.dart';

class ListGasto extends StatelessWidget {
  final Gasto gasto;

  const ListGasto({Key? key, required this.gasto}) : super(key: key);

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

    return ListTile(
      title: Text(gasto.descripcion),
      subtitle: Text(nivelGasto),
      trailing: Text('\$${gasto.precio.toStringAsFixed(2)}'),
    );
  }
}