import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Registros extends StatefulWidget {
  @override
  _RegistrosState createState() => _RegistrosState();
}

class _RegistrosState extends State<Registros> {
  final box = GetStorage();
  final _boldStyle =
      TextStyle(fontWeight: FontWeight.normal, color: Colors.white);
  final _ingresoController = TextEditingController();
  final _retiroController = TextEditingController();

  double contador = 0;
  double total = 0;

  @override
  void initState() {
    super.initState();
    total = box.read('total') ?? 0;
    contador = box.read('contador') ?? 0; //almacena el valor
  }

  void _ingresarMonto() {
    double monto = double.tryParse(_ingresoController.text) ?? 0;
    if (monto <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El valor ingresado no es válido')),
      );
    } else {
      total ??= 0;
      box.write('total', total + monto);
      contador += monto;
      box.write('contador', contador);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Monto ingresado correctamente')),
      );
      _ingresoController.clear();
      setState(() {});
    }
  }

  void _retirarMonto() {
    double monto = double.tryParse(_retiroController.text) ?? 0;
    double balance = contador;
    if (monto <= 0 || monto > balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El valor ingresado no es válido')),
      );
    } else {
      total ??= 0;
      box.write('total', balance - monto);
      contador -= monto;
      box.write('contador', contador);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Monto retirado exitosamente')),
      );
      _retiroController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimiento de Activos'),
        backgroundColor: Color.fromARGB(255, 30, 31, 49),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://c0.wallpaperflare.com/preview/241/384/859/analysis-analytics-analyzing-annual.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Maneja tu dinero aquí',
                style: _boldStyle.copyWith(fontSize: 24.0),
              ),
            ),

            SizedBox(height: 16.0),
            TextField(
              controller: _ingresoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingresar monto',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _ingresarMonto,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[700],
              ),
              child: Text('Ingresar dinero'),
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: _retiroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Retirar monto',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _retirarMonto,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[700],
              ),
              child: Text('Retirar dinero'),
            ),

            SizedBox(height: 32.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Total: $contador',
                style: _boldStyle.copyWith(fontSize: 20.0),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
