import 'package:flutter/material.dart';
import 'resumen.dart';
import 'Registros.dart';
//import 'compras_page.dart';
//import 'ventas_page.dart';

class Opciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Opciones'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Resumen'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Resumen()),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Movimiento de Activos'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registros()),
                  );
                },
              ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   child: Text('Compras'),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ComprasPage()),
              //     );
              //   },
              // ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   child: Text('Ventas'),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => VentasPage()),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
