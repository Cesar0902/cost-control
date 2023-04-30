import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Movimientos extends StatefulWidget {
  @override
  _MovimientosState createState() => _MovimientosState();
}

class _MovimientosState extends State<Movimientos> {
  final box = GetStorage();

  List<Map<String, dynamic>> movimientos = [];

  int ingresos = 0;
  int retiros = 0;

  @override
  void initState() {
    super.initState();
    movimientos = box.read('movimientos')?.cast<Map<String, dynamic>>() ?? [];

    // Calcular el número de ingresos y retiros
    for (final movimiento in movimientos) {
      if (movimiento['monto'] > 0) {
        ingresos++;
      } else {
        retiros++;
      }
    }
  }

  void _agregarMovimiento(double monto, String tipo, String descripcion) {
    movimientos.add({
      'monto': monto,
      'tipo': tipo,
      'descripcion': descripcion,
      'fecha': DateTime.now().toString(),
    });
    box.write('movimientos', movimientos);

    // Actualizar el número de ingresos y retiros
    if (tipo == 'Ingreso') {
      ingresos++;
    } else {
      retiros++;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimientos'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Ingresos: $ingresos'),
            Text('Retiros: $retiros'),
            Expanded(
              child: ListView.builder(
                itemCount: movimientos.length,
                itemBuilder: (context, index) {
                  final movimiento = movimientos[index];
                  final monto = movimiento['monto'];
                  final tipo = movimiento['tipo'];
                  final descripcion = movimiento['descripcion'];
                  final fecha = DateTime.parse(movimiento['fecha']);

                  return ListTile(
                    leading: tipo == 'Ingreso'
                        ? Icon(Icons.add)
                        : Icon(Icons.remove),
                    title: Text('$tipo de $monto pesos'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Descripción: $descripcion'),
                        Text(
                            'Fecha: ${fecha.day}/${fecha.month}/${fecha.year}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  double? monto;
                  String? descripcion;

                  return AlertDialog(
                    title: Text('Agregar ingreso'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Monto',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            monto = double.tryParse(value);
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Descripción (opcional)',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            descripcion = value;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (monto == null || monto! <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('El valor ingresado no es válido')),
                            );
                          } else {
                            final tipo = monto! > 0 ? 'Ingreso' : 'Gasto';
                            _agregarMovimiento(
                                monto!.abs(), tipo, descripcion!);
                            if (tipo == 'Ingreso') {
                              box.write('total_ingresos',
                                  (box.read('total_ingresos') ?? 0) + monto!);
                            } else {
                              box.write('total_gastos',
                                  (box.read('total_gastos') ?? 0) + monto!);
                            }
                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Agregar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  double? monto;
                  String? descripcion;

                  return AlertDialog(
                    title: Text('Agregar gasto'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Monto',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            monto = double.tryParse(value);
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            descripcion = value;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (monto == null || monto! <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('El valor ingresado no es válido')),
                            );
                          } else {
                            _agregarMovimiento(
                                -monto!.abs(), 'Gasto', descripcion!);
                            box.write('total_gastos',
                                (box.read('total_gastos') ?? 0) + monto!);
                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Agregar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
