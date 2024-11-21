import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:examen_oscar_barrios/modules/autos/entities/autos.dart';
import 'package:examen_oscar_barrios/modules/widgets/details_autos.dart';
import 'package:examen_oscar_barrios/modules/widgets/list_autos.dart';
import 'package:examen_oscar_barrios/modules/autos/screens/nuevo_auto.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = FirebaseFirestore.instance;
  List<Auto> autos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAutos();
  }

  Future<void> _fetchAutos() async {
    try {
      db.collection('autos').snapshots().listen((snapshot) {
        autos = snapshot.docs.map((doc) {
          return Auto(
            numero_poliza: (doc['numero_poliza'] as num?)?.toDouble() ?? 0.0,
            nombre: doc['nombre'] ?? '',
            modelo: doc['modelo'] ?? '',
            fecha_expiracion: (doc['fecha_expiracion'] as Timestamp).toDate(),
            url_imagen: doc['url_imagen'] ?? '',
          );
        }).toList();
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print('Error fetching autos: $e');
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
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NuevoAutoScreen()))
              .then((newAuto) {
            if (newAuto != null) {
              // No es necesario actualizar el estado aquí, el StreamBuilder lo hace automáticamente
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: autos.isEmpty
          ? const Center(child: Text("No hay autos registrados."))
          : ListView.builder(
              itemCount: autos.length,
              itemBuilder: (context, index) {
                final auto = autos[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsAuto(auto: auto)));
                  },
                  child: ListAuto(auto: auto),
                );
              },
            ),
    );
  }
}
