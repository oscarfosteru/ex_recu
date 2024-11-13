import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/gastos/entities/gastos.dart';
import 'package:examen_oscar_barrios/modules/widgets/details_gastos.dart';
import 'package:examen_oscar_barrios/modules/widgets/list_gastos.dart';
import 'package:examen_oscar_barrios/modules/gastos/screens/nuevo_gasto.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = FirebaseFirestore.instance;
  List<Gasto> gastos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGastos();

    // Corrección: Convertir precios a double en la carga inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _convertPreciosToDouble();
    });
  }

  Future<void> _convertPreciosToDouble() async {
    try {
      final snapshot = await db.collection('gastos').get();
      gastos = snapshot.docs.map((doc) {
        final precio = (doc['precio'] is String)
            ? double.tryParse(doc['precio']) ?? 0.0
            : (doc['precio'] as num?)?.toDouble() ?? 0.0;
        return Gasto(
          descripcion: doc['descripcion'] ?? '',
          precio: precio,
        );
      }).toList();
      setState(() {});
    } catch (e) {
      print('Error converting precios: $e');
    }
  }

  Future<void> _fetchGastos() async {
    try {
      db.collection('gastos').snapshots().listen((snapshot) {
        gastos = snapshot.docs.map((doc) {
          final precio = (doc['precio'] as num?)?.toDouble() ?? 0.0;
          return Gasto(
            descripcion: doc['descripcion'] ?? '',
            precio: precio,
          );
        }).toList();
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print('Error fetching gastos: $e');
    }
  }


  @override 
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NuevoGastoScreen())).then((newGasto) {
            if (newGasto != null) {
              // No es necesario actualizar el estado aquí, el StreamBuilder lo hace automáticamente
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: gastos.isEmpty
          ? const Center(child: Text("No hay gastos registrados."))
          : ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                final gasto = gastos[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => DetailsGasto(gasto: gasto)));
                  },
                  child: ListGasto(gasto: gasto),
                );
              },
            ),
    );
  }
}