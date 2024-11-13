import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/gastos/entities/gastos.dart';

class NuevoGastoScreen extends StatefulWidget {
  const NuevoGastoScreen({Key? key}) : super(key: key);

  @override
  State<NuevoGastoScreen> createState() => _NuevoGastoScreenState();
}

class _NuevoGastoScreenState extends State<NuevoGastoScreen> {
  final _formKey = GlobalKey<FormState>();
  final descripcionController = TextEditingController();
  final precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un precio';
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newGasto = Gasto(
                      descripcion: descripcionController.text,
                      precio: double.parse(precioController.text),
                    );

                    FirebaseFirestore.instance.collection('gastos').add({
                      'descripcion': newGasto.descripcion,
                      'precio': newGasto.precio,
                    });

                    Navigator.pop(context, newGasto); // Devuelve el nuevo gasto
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
    descripcionController.dispose();
    precioController.dispose();
    super.dispose();
  }
}