import 'package:flutter/material.dart';

class Auto {
  final double numero_poliza;
  final String nombre;
  final String modelo;
  final DateTime fecha_expiracion;
  final String url_imagen;

  Auto({
    required this.numero_poliza,
    required this.nombre,
    required this.modelo,
    required this.fecha_expiracion,
    required this.url_imagen,
  });
}

class ContentColumn extends StatelessWidget {
  final Auto auto;

  const ContentColumn({
    super.key,
    required this.auto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Nombre: ${auto.nombre}'),
          Text('Modelo: ${auto.modelo}'),
          Text('Número de Póliza: ${auto.numero_poliza}'),
          Text(
              'Fecha de Expiración: ${auto.fecha_expiracion.toLocal().toString().split(' ')[0]}'),
          Image.network(
            auto.url_imagen,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Text('No se pudo cargar la imagen');
            },
          ),
        ],
      ),
    );
  }
}
