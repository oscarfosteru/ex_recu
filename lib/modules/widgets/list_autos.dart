import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/autos/entities/autos.dart';

class ListAuto extends StatelessWidget {
  final Auto auto;

  const ListAuto({super.key, required this.auto});

  @override
  Widget build(BuildContext context) {
    String estadoAuto = '';
    DateTime now = DateTime.now();
    if (auto.fecha_expiracion.isBefore(now)) {
      estadoAuto = 'Expirado';
    } else {
      estadoAuto = 'Vigente';
    }

    return ListTile(
      leading: Image.network(
        auto.url_imagen,
        headers: const {'Access-Control-Allow-Origin': '*'},
      ),
      title: Text(auto.nombre),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${auto.modelo} - $estadoAuto'),
          Text(
              'Fecha de Expiración: ${auto.fecha_expiracion.toLocal().toString().split(' ')[0]}'),
        ],
      ),
      trailing: Text('Póliza: ${auto.numero_poliza}'),
    );
  }
}
