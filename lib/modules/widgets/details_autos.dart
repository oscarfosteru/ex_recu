import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/autos/entities/autos.dart';
import 'package:intl/intl.dart';

class DetailsAuto extends StatelessWidget {
  final Auto auto;

  const DetailsAuto({super.key, required this.auto});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime expirationDate = auto.fecha_expiracion;
    final Duration difference = expirationDate.difference(now);
    String statusText;
    Color statusColor;

    if (difference.isNegative) {
      statusText = 'Expirado';
      statusColor = Colors.red;
    } else if (difference.inDays <= 30) {
      statusText = 'Póliza próxima a expirar';
      statusColor = Colors.yellow;
    } else {
      statusText = 'Póliza al corriente';
      statusColor = Colors.green;
    }

    // Usar un proxy para evitar problemas de CORS
    final String imageUrl =
        'https://cors-anywhere.herokuapp.com/${auto.url_imagen}';

    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del Auto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(auto.nombre,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Modelo: ${auto.modelo}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('Número de Póliza: ${auto.numero_poliza.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text(
                'Fecha de Expiración: ${DateFormat('yyyy-MM-dd').format(expirationDate)}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text(
              statusText,
              style: TextStyle(fontSize: 18, color: statusColor),
            ),
            const SizedBox(height: 16),
            Image.network(imageUrl),
          ],
        ),
      ),
    );
  }
}
