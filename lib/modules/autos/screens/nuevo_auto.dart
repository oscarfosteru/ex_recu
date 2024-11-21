import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/autos/entities/autos.dart';

class NuevoAutoScreen extends StatefulWidget {
  const NuevoAutoScreen({Key? key}) : super(key: key);

  @override
  State<NuevoAutoScreen> createState() => _NuevoAutoScreenState();
}

class _NuevoAutoScreenState extends State<NuevoAutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final numeroPolizaController = TextEditingController();
  final nombreController = TextEditingController();
  final modeloController = TextEditingController();
  final urlImagenController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Auto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: numeroPolizaController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Número de Póliza'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de póliza';
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un modelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: TextEditingController(
                    text: _selectedDate != null
                        ? _selectedDate!.toLocal().toString().split(' ')[0]
                        : ''),
                decoration:
                    const InputDecoration(labelText: 'Fecha de Expiración'),
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Por favor seleccione una fecha de expiración';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: urlImagenController,
                decoration:
                    const InputDecoration(labelText: 'URL de la Imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una URL de imagen';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newAuto = Auto(
                      numero_poliza: double.parse(numeroPolizaController.text),
                      nombre: nombreController.text,
                      modelo: modeloController.text,
                      fecha_expiracion: _selectedDate!,
                      url_imagen: urlImagenController.text,
                    );

                    FirebaseFirestore.instance.collection('autos').add({
                      'numero_poliza': newAuto.numero_poliza,
                      'nombre': newAuto.nombre,
                      'modelo': newAuto.modelo,
                      'fecha_expiracion':
                          Timestamp.fromDate(newAuto.fecha_expiracion),
                      'url_imagen': newAuto.url_imagen,
                    });

                    Navigator.pop(context, newAuto); // Devuelve el nuevo auto
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    numeroPolizaController.dispose();
    nombreController.dispose();
    modeloController.dispose();
    urlImagenController.dispose();
    super.dispose();
  }
}
